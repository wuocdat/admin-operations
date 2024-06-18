import 'package:flutter/material.dart';
import 'package:tctt_mobile/shared/widgets/bottom_loader.dart';
import 'package:tctt_mobile/shared/widgets/empty_list_message.dart';

class RichListView<T> extends StatefulWidget {
  const RichListView({
    super.key,
    required this.hasReachedMax,
    required this.itemCount,
    required this.itemBuilder,
    required this.onReachedEnd,
    this.reverse = false,
    this.physics,
    this.onRefresh,
    this.startPadding = 12,
    this.endPadding = 12,
    this.bottomPadding = 8,
    this.topPadding = 0,
  });

  final bool hasReachedMax;
  final int itemCount;
  final bool reverse;
  final ScrollPhysics? physics;
  final void Function() onReachedEnd;
  final Widget Function(int) itemBuilder;
  final Future<void> Function()? onRefresh;
  final double startPadding;
  final double endPadding;
  final double topPadding;
  final double bottomPadding;

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
    return widget.itemCount != 0
        ? RefreshIndicator(
            onRefresh: widget.onRefresh ?? () async {},
            child: ListView.builder(
              physics: widget.physics,
              reverse: widget.reverse,
              itemBuilder: (context, index) {
                return index >= widget.itemCount
                    ? const BottomLoader()
                    : widget.itemBuilder(index);
              },
              itemCount: widget.hasReachedMax
                  ? widget.itemCount
                  : widget.itemCount + 1,
              controller: _scrollController,
              padding: EdgeInsetsDirectional.only(
                start: widget.startPadding,
                end: widget.endPadding,
                bottom: widget.bottomPadding,
                top: widget.topPadding,
              ),
            ),
          )
        : Stack(
            children: [
              const EmptyListMessage(message: "Không có mục nào"),
              RefreshIndicator(
                onRefresh: widget.onRefresh ?? () async {},
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Container(),
                  itemCount: 0,
                ),
              )
            ],
          );
  }
}
