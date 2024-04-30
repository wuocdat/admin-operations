import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/dashboard/bloc/dashboard_bloc.dart';
import 'package:tctt_mobile/dashboard/widget/parameter_item.dart';

class MainParameter extends StatelessWidget {
  const MainParameter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
            child: Text(
              'Các thông số chính của hệ thống',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Container(
            height: 250,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 8,
              children: [
                Builder(builder: (context) {
                  return ParameterItem(
                    parameterValue: context
                        .select((DashboardBloc bloc) => bloc.state.task.all),
                    title: "Nhiệm vụ",
                  );
                }),
                ParameterItem(
                  parameterValue: context
                      .select((DashboardBloc bloc) => bloc.state.mail.all),
                  title: "Hòm thư",
                  themeColor: Colors.amber[700],
                ),
                ParameterItem(
                  parameterValue: context
                      .select((DashboardBloc bloc) => bloc.state.target.all),
                  title: "Đối tượng",
                  themeColor: Colors.redAccent,
                ),
                const ParameterItem(
                  parameterValue: 16,
                  title: "Nhiệm vụ",
                  themeColor: Colors.blueAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
