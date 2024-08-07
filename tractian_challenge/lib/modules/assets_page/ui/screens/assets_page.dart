import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tractian_challenge/modules/assets_page/controllers/asset_controller.dart';
import 'package:tractian_challenge/modules/assets_page/controllers/location_controller.dart';
import 'package:tractian_challenge/modules/assets_page/models/asset.dart';
import 'package:tractian_challenge/modules/assets_page/models/location.dart';
import 'package:tractian_challenge/modules/assets_page/models/tree_node.dart';
import 'package:tractian_challenge/modules/assets_page/ui/widgets/assets_filter_button.dart';
import 'package:tractian_challenge/modules/home_page/controllers/company_controller.dart';
import 'package:tractian_challenge/modules/home_page/models/company.dart';
import 'package:tractian_challenge/shared/app_theme.dart';
import 'package:tractian_challenge/shared/widgets/appbar_leading_button.dart';
import 'package:tractian_challenge/shared/widgets/snack.dart';
import 'package:tractian_challenge/shared/widgets/text_field.dart';
import 'package:tractian_challenge/shared/widgets/tree_tile.dart';

class AssetsPage extends StatefulWidget {
  final Company company;
  const AssetsPage({super.key, required this.company});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  final TextEditingController filterController = TextEditingController();
  final LocationController locationController = LocationController();
  final AssetController assetsController = AssetController();

  String companyDirectory = '';

  bool isLoading = false;
  bool filterEnergySensors = false;
  bool filterCritical = false;

  List<Asset> assets = [];
  List<Location> locations = [];
  List<TreeNode> roots = [];
  List<TreeNode> viewTrees = [];

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  void debugPrint(Object value) {
    if (kDebugMode) {
      print(value);
    }
  }

  bool hasActiveFilters() {
    return filterCritical ||
        filterEnergySensors ||
        filterController.text.isNotEmpty;
  }

  Future<void> loadCompanyDirectory() async {
    try {
      companyDirectory = CompanyController.getCompanyDirectory(widget.company);
    } catch (e) {
      debugPrint(e);
      Snack.erro(
          context: context, texto: 'Falha ao carregar o diretório da empresa');
    }
  }

  Future<void> loadInitialData() async {
    setState(() => isLoading = true);
    await loadCompanyDirectory();
    await loadLocation();
    await loadAssets();
    roots = TreeNode.buildForest(locations, assets);
    viewTrees.addAll(roots);
    setState(() => isLoading = false);
  }

  Future<void> applyFilters() async {
    if (!hasActiveFilters()) {
      viewTrees.clear();

      viewTrees.addAll(roots);
    } else {
      viewTrees = TreeNode.buildFilteredForest(locations, assets, (item) {
        if (item is Location) {
          if (filterController.text.isEmpty) {
            return false;
          }
          return item.name
              .toUpperCase()
              .contains(filterController.text.toUpperCase());
        }
        if (item is Asset) {
          if (filterController.text.isEmpty) {
            return (filterEnergySensors && item.sensorType == 'energy') ||
                (filterCritical && item.status == 'alert');
          }
          return item.name
                  .toUpperCase()
                  .contains(filterController.text.toUpperCase()) ||
              (filterEnergySensors && item.sensorType == 'energy') ||
              (filterCritical && item.status == 'alert');
        }
        return false;
      });
    }
    setState(() {
      viewTrees;
    });
  }

  Future<List<TreeNode<dynamic>>> loadChildren(TreeNode<dynamic> node) async {
    return node.children ?? [];
  }

  List<Widget> buildTreeView(
    List<TreeNode<dynamic>> nodes,
    Function(TreeNode<dynamic>) onExpand,
  ) {
    return nodes.map((node) {
      String imagePath = '';
      String title = node.item.name;
      if (node.item is Location) {
        imagePath = 'assets/images/location.png';
      } else if (node.item is Asset) {
        Asset asset = node.item;
        if (asset.sensorType != null) {
          imagePath = 'assets/images/components.png';
        } else {
          imagePath = 'assets/images/assets.png';
        }
      }

      Widget? trailing;
      if (node.item is Asset) {
        final Asset current = node.item;
        if (current.sensorType == 'energy') {
          trailing = const Icon(
            Icons.bolt,
            color: Colors.green,
            size: 20,
          );
        }
        if (current.status == 'alert') {
          trailing = const Icon(
            Icons.circle,
            color: Colors.red,
            size: 16,
          );
        }
      }

      return TreeTile(
        title: title,
        imagePath: imagePath,
        trailing: trailing,
        children:
            node.isLoaded ? buildTreeView(node.children ?? [], onExpand) : [],
        onExpand: () async {
          if (!node.isLoaded) {
            List<TreeNode<dynamic>> newChildren = await loadChildren(node);
            setState(() {
              node.isLoaded = true;
              node.children = newChildren;
            });
            onExpand(node);
          }
        },
      );
    }).toList();
  }

  Future<void> loadLocation() async {
    try {
      locations =
          await locationController.getList(companyDirectory: companyDirectory);
    } catch (e) {
      debugPrint(e);
      if (mounted) {
        Snack.erro(context: context, texto: 'Falha ao carregar Localizações');
      }
    }
  }

  Future<void> loadAssets() async {
    try {
      assets =
          await assetsController.getList(companyDirectory: companyDirectory);
    } catch (e) {
      debugPrint(e);
      if (mounted) {
        Snack.erro(context: context, texto: 'Falha ao carregar Ativos');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppbarLeadingButton(),
        title: const Text('Ativos'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: filterController,
                              onChange: (value) {
                                applyFilters();
                              },
                              hint: 'Buscar Ativo ou Local',
                              prefixIcon: Icons.search,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: AssetsFilterButton(
                              iconData: Icons.bolt,
                              label: 'Sensor de Energia',
                              onPressed: (final ButtonStatus status) {
                                filterEnergySensors =
                                    status == ButtonStatus.activated;
                                applyFilters();
                              },
                            ),
                          ),
                          AssetsFilterButton(
                            iconData: Icons.warning,
                            label: 'Crítico',
                            onPressed: (final ButtonStatus status) {
                              filterCritical = status == ButtonStatus.activated;
                              applyFilters();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: buildTreeView(viewTrees, (node) {
                      setState(() {});
                    }),
                  ),
                ),
              ],
            ),
    );
  }
}
