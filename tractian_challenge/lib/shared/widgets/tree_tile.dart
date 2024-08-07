import 'package:flutter/material.dart';

class TreeTile extends StatefulWidget {
  final String title;
  final Widget? trailing;
  final String? imagePath;
  final bool showVerticalLine;
  final List<Widget> children;
  final Function? onTap;
  final Function? onExpand;

  const TreeTile({
    super.key,
    required this.title,
    required this.children,
    this.showVerticalLine = true,
    this.trailing,
    this.imagePath,
    this.onTap,
    this.onExpand,
  });

  @override
  State<TreeTile> createState() => _TreeTileState();
}

class _TreeTileState extends State<TreeTile>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.children.isEmpty && _isExpanded) {
      return;
    }
    widget.onTap?.call();
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
        widget.onExpand?.call();
      } else {
        _controller.reverse();
      }
    });
  }

  Widget? leadingIconIndicator() {
    if (widget.children.isEmpty && _isExpanded) {
      return null;
    }
    return RotationTransition(
      turns: _controller.drive(Tween(begin: 0.5, end: 0.0)),
      child: const Icon(Icons.expand_more),
    );
  }

  Border? getBorder() {
    if (!widget.showVerticalLine) {
      return null;
    }
    return Border(
      left: BorderSide(
        style: BorderStyle.solid,
        width: 1,
        color: Colors.grey.shade300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: leadingIconIndicator(),
          title: Row(
            children: [
              if (widget.imagePath != null) ...{
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    widget.imagePath!,
                    width: 24,
                    height: 24,
                  ),
                )
              },
              Flexible(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (widget.trailing != null) ...{
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: widget.trailing!,
                )
              },
            ],
          ),
          onTap: _handleTap,
        ),
        ClipRect(
          child: Align(
            heightFactor: _isExpanded ? 1.0 : 0.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 26),
              child: Container(
                decoration: BoxDecoration(border: getBorder()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.children,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
