import 'package:flutter/material.dart';
import 'package:tctt_mobile/theme/colors.dart';
import 'package:tctt_mobile/widgets/rich_list_view.dart';

class SubjectList extends StatelessWidget {
  const SubjectList({super.key});

  @override
  Widget build(BuildContext context) {
    return RichListView(
      hasReachedMax: false,
      itemCount: 1,
      itemBuilder: (index) => const SubjectItem(),
      onReachedEnd: () {},
    );
  }
}

class SubjectItem extends StatelessWidget {
  const SubjectItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x230E151B),
            offset: Offset(
              0.0,
              2,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primaryBackground,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'An-Nam Yakukohaiyo',
              style: TextStyle(
                color: Color(0xFF14181B),
                fontSize: 24,
                letterSpacing: 0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text('Trang cá nhân'),
            const SizedBox(height: 2),
            const Text('Tên facebook: An-Nam Yakukohaiyo'),
            const SizedBox(height: 2),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'UID: ',
                    style: DefaultTextStyle.of(context).style,
                  ),
                  TextSpan(
                    text: '100008683980651',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 2),
            const Text('Theo dõi'),
            const SizedBox(height: 2),
            const Text('Được thêm từ ngày 28/11/2021'),
          ],
        ),
      ),
    );
  }
}
