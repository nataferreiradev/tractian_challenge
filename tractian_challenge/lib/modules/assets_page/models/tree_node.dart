import 'package:tractian_challenge/modules/assets_page/models/asset.dart';
import 'package:tractian_challenge/modules/assets_page/models/location.dart';

class TreeNode<T> {
  final T item;
  final String id;
  final String? parentId;
  List<TreeNode>? children;
  bool isLoaded;

  TreeNode({
    required this.item,
    required this.id,
    this.parentId,
    this.children,
    this.isLoaded = false,
  });

  static List<TreeNode<dynamic>> buildForest(
      List<Location> locations, List<Asset> assets) {
    final Map<String, TreeNode<dynamic>> allNodes = {};

    for (var location in locations) {
      allNodes[location.id] = TreeNode<Location>(
        item: location,
        id: location.id,
        parentId: location.parentId,
        children: [],
      );
    }

    for (var asset in assets) {
      allNodes[asset.id] = TreeNode<Asset>(
        item: asset,
        id: asset.id,
        parentId: asset.parentId ?? asset.locationId,
        children: [],
      );
    }

    List<TreeNode<dynamic>> forest = [];

    for (var node in allNodes.values) {
      if (node.parentId == null) {
        forest.add(node);
      } else {
        if (allNodes.containsKey(node.parentId!)) {
          allNodes[node.parentId!]!.children ??= [];
          allNodes[node.parentId!]!.children!.add(node);
        } else {
          forest.add(node);
        }
      }
    }

    return forest;
  }

  static List<TreeNode<dynamic>> buildFilteredForest(
    List<Location> locations,
    List<Asset> assets,
    bool Function(dynamic) predicate,
  ) {
    final Map<String, TreeNode<dynamic>> allNodes = {};
    final Set<String> relevantIds = {};
    final Map<String, List<String>> nodePaths = {};

    for (var location in locations) {
      allNodes[location.id] = TreeNode<Location>(
        item: location,
        id: location.id,
        parentId: location.parentId,
        children: [],
      );
    }

    for (var asset in assets) {
      allNodes[asset.id] = TreeNode<Asset>(
        item: asset,
        id: asset.id,
        parentId: asset.parentId ?? asset.locationId,
        children: [],
      );
    }

    void filterNode(String nodeId) {
      final node = allNodes[nodeId];
      if (node == null) return;

      nodePaths[nodeId] = _getPathToRoot(nodeId, allNodes);

      if (predicate(node.item)) {
        relevantIds.add(node.id);
      }

      if (node.parentId != null) {
        filterNode(node.parentId!);
      }
    }

    for (var node in allNodes.values) {
      filterNode(node.id);
    }

    final Map<String, TreeNode<dynamic>> filteredMap = {};
    for (var nodeId in nodePaths.keys) {
      final node = allNodes[nodeId];
      if (node != null) {
        filteredMap[nodeId] = TreeNode<dynamic>(
          item: node.item,
          id: node.id,
          parentId: node.parentId,
          children: [],
          isLoaded: node.isLoaded,
        );
      }
    }

    for (var nodeId in filteredMap.keys) {
      final node = filteredMap[nodeId];
      if (node == null) continue;

      final parentId = node.parentId;
      if (parentId != null) {
        final parentNode = filteredMap[parentId];
        if (parentNode != null) {
          parentNode.children ??= [];
          parentNode.children!.add(node);
        }
      }
    }

    final List<TreeNode<dynamic>> filteredForest = [];
    for (var node in filteredMap.values) {
      if (node.parentId == null &&
          _containsFilteredNode(node.id, filteredMap, relevantIds)) {
        filteredForest.add(node);
      }
    }

    return filteredForest;
  }

  static bool _containsFilteredNode(String nodeId,
      Map<String, TreeNode<dynamic>> filteredMap, Set<String> relevantIds) {
    final node = filteredMap[nodeId];
    if (node == null) return false;

    if (relevantIds.contains(node.id)) {
      return true;
    }

    if (node.children != null) {
      for (var child in node.children!) {
        if (_containsFilteredNode(child.id, filteredMap, relevantIds)) {
          return true;
        }
      }
    }

    return false;
  }

  static List<String> _getPathToRoot(
      String nodeId, Map<String, TreeNode<dynamic>> allNodes) {
    final List<String> path = [];
    String? currentId = nodeId;

    while (currentId != null) {
      path.add(currentId);
      final node = allNodes[currentId];
      currentId = node?.parentId;
    }

    return path.reversed
        .toList();
  }
}
