import 'package:flutter/material.dart';
import 'package:tctt_mobile/widgets/bottom_loader.dart';

class RichListView<T> extends StatefulWidget {
  const RichListView({
    super.key,
    required this.hasReachedMax,
    required this.itemCount,
    required this.itemBuilder,
    required this.onReachedEnd,
    this.reverse = false,
    this.physicsl,
  });

  final bool hasReachedMax;
  final int itemCount;
  final bool reverse;
  final ScrollPhysics? physicsl;
  final void Function() onReachedEnd;
  final Widget Function(int) itemBuilder;

  @override
  State<RichListView> createState() => _RichListViewState();
}

class _RichListViewState extends State<RichListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && !widget.hasReachedMax) {
      widget.onReachedEnd();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: widget.physicsl,
      reverse: widget.reverse,
      itemBuilder: (context, index) {
        return index >= widget.itemCount
            ? const BottomLoader()
            : widget.itemBuilder(index);
      },
      itemCount: widget.hasReachedMax ? widget.itemCount : widget.itemCount + 1,
      controller: _scrollController,
      padding: const EdgeInsetsDirectional.only(
        start: 12,
        end: 12,
        bottom: 8,
      ),
    );
  }
}
