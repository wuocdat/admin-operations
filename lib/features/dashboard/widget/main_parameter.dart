import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:tctt_mobile/features/dashboard/widget/parameter_item.dart';

class MainParameter extends StatelessWidget {
  const MainParameter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
      width: double.infinity,
      child: Wrap(
        runSpacing: 8,
        alignment: WrapAlignment.spaceBetween,
        children: [
          ParameterItem(
            parameterValue:
                context.select((DashboardBloc bloc) => bloc.state.task.all),
            title: "Nhiệm vụ",
          ),
          ParameterItem(
            parameterValue:
                context.select((DashboardBloc bloc) => bloc.state.mail.all),
            title: "Hòm thư",
            themeColor: Colors.amber[700],
          ),
          ParameterItem(
            parameterValue: context
                .select((DashboardBloc bloc) => bloc.state.target.reactionary),
            title: "Đối tượng",
            themeColor: Colors.redAccent,
          ),
          ParameterItem(
            parameterValue: context
                .select((DashboardBloc bloc) => bloc.state.target.subject_35),
            title: "Trang truyền thông",
            themeColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
