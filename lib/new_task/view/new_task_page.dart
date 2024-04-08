import 'package:flutter/material.dart';
import 'package:flutter_tree/flutter_tree.dart';
import 'package:tctt_mobile/widgets/border_container.dart';
import 'package:tctt_mobile/widgets/contained_button.dart';
import 'package:tctt_mobile/widgets/dopdown.dart';
import 'package:tctt_mobile/widgets/input.dart';

const List<String> list = <String>['Báo xấu', 'Điều tra', 'Giám sát', 'Khác'];

final serverData = [
  {
    "checked": true,
    "children": [
      {
        "checked": true,
        "show": false,
        "children": [],
        "id": 11,
        "pid": 1,
        "text": "Child title 11",
      },
    ],
    "id": 1,
    "pid": 0,
    "show": false,
    "text": "Parent title 1",
  },
  {
    "checked": true,
    "show": false,
    "children": [],
    "id": 2,
    "pid": 0,
    "text": "Parent title 2",
  },
  {
    "checked": true,
    "children": [],
    "id": 3,
    "pid": 0,
    "show": false,
    "text": "Parent title 3",
  },
];

/// Map server data to tree node data
TreeNodeData mapServerDataToTreeData(Map data) {
  return TreeNodeData(
    extra: data,
    title: data['text'],
    expaned: data['show'],
    checked: data['checked'],
    children:
        List.from(data['children'].map((x) => mapServerDataToTreeData(x))),
  );
}

class NewTaskPage extends StatelessWidget {
  NewTaskPage({super.key})
      : treeData = serverData.map((x) => mapServerDataToTreeData(x)).toList();

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => NewTaskPage(),
    );
  }

  /// Generate tree data
  final List<TreeNodeData> treeData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Nhiệm vụ mới',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Urbanist',
                letterSpacing: 0,
              ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  const BorderInput(
                    labelText: 'Tiêu đề',
                    autoFocus: true,
                  ),
                  const SizedBox(height: 16),
                  BorderDropdown(
                    items: list,
                    initialSelection: list.first,
                  ),
                  const SizedBox(height: 16),
                  const BorderInput(
                    labelText: 'Nội dung',
                    maxLines: 16,
                    minLines: 6,
                  ),
                  const SizedBox(height: 16),
                  BorderContainer(
                    child: TreeView(
                      data: treeData,
                      showCheckBox: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  BorderContainer(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_a_photo_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 16),
                          const Text('Đính kèm ảnh'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  BorderContainer(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 16),
                          const Text('Đánh dấu quan trọng'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ContainedButton(
                    onPressed: () {},
                    text: "Tạo mới",
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
