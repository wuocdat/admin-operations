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
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
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
            parameterValue:
                context.select((DashboardBloc bloc) => bloc.state.target.all),
            title: "Đối tượng",
            themeColor: Colors.redAccent,
          ),
          const ParameterItem(
            parameterValue: 16,
            title: "Trang truyền thông",
            themeColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
