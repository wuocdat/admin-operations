part of 'target_cubit.dart';

enum SubjectViewOption { list, actions }

extension SubjectViewOptionX on SubjectViewOption {
  String get title {
    switch (this) {
      case SubjectViewOption.list:
        return "Danh sách";
      case SubjectViewOption.actions:
        return "Hoạt động";
    }
  }
}

enum TargetOptions { subject, chanel }

enum FbPageType { fanpage, personalPage, openGroup }

extension FbPageTypeX on FbPageType {
  String get title {
    switch (this) {
      case FbPageType.fanpage:
        return 'Fanpage';
      case FbPageType.openGroup:
        return 'Nhóm mở';
      case FbPageType.personalPage:
        return 'Trang cá nhân';
    }
  }

  String get strId {
    switch (this) {
      case FbPageType.fanpage:
        return '1';
      case FbPageType.openGroup:
        return '2';
      case FbPageType.personalPage:
        return '0';
    }
  }
}

extension TargetOptionsX on TargetOptions {
  String get title {
    if (this == TargetOptions.subject) {
      return "Đối tượng";
    } else {
      return "Kênh ta";
    }
  }

  int get typeAc {
    switch (this) {
      case TargetOptions.subject:
        return 0;
      case TargetOptions.chanel:
        return 1;
    }
  }

  bool get isSubject => this == TargetOptions.subject;
}

class TargetState extends Equatable {
  const TargetState._({
    this.selectedOption = TargetOptions.subject,
    this.viewIndex = 0,
    this.startDate,
    this.endDate,
    this.updateFilterCount = 0,
    this.fbPageType,
    this.targetName = '',
    this.downloadingStatus = FetchDataStatus.initial,
    this.currentUnit = Unit.empty,
    this.stepUnitsList = const [],
    this.subUnitsList = const [],
  });

  const TargetState.subject() : this._();

  const TargetState.chanel() : this._(selectedOption: TargetOptions.chanel);

  final TargetOptions selectedOption;

  final int viewIndex;

  final DateTime? startDate;

  final DateTime? endDate;

  final FbPageType? fbPageType;

  final String targetName;

  final FetchDataStatus downloadingStatus;

  final int updateFilterCount;

  final Unit currentUnit;

  final List<Unit> stepUnitsList;

  final List<Unit> subUnitsList;

  TargetState copyWith({
    TargetOptions? selectedOption,
    int? viewIndex,
    DateTime? startDate,
    DateTime? endDate,
    int? updateFilterCount,
    FbPageType? fbPageType,
    bool? unsetFbType,
    String? targetName,
    FetchDataStatus? downloadingStatus,
    Unit? currentUnit,
    List<Unit>? stepUnitsList,
    List<Unit>? subUnitsList,
  }) {
    return TargetState._(
      selectedOption: selectedOption ?? this.selectedOption,
      viewIndex: viewIndex ?? this.viewIndex,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      updateFilterCount: updateFilterCount ?? this.updateFilterCount,
      fbPageType: unsetFbType == true ? null : fbPageType ?? this.fbPageType,
      targetName: targetName ?? this.targetName,
      downloadingStatus: downloadingStatus ?? this.downloadingStatus,
      currentUnit: currentUnit ?? this.currentUnit,
      stepUnitsList: stepUnitsList ?? this.stepUnitsList,
      subUnitsList: subUnitsList ?? this.subUnitsList,
    );
  }

  bool get filterChanged {
    final otherStartDatePicked = startDate?.stringFormat !=
        DateTime.now().subtract(const Duration(days: 1)).stringFormat;
    final otherEndDatePicked =
        endDate?.stringFormat != DateTime.now().stringFormat;
    final typePicked = fbPageType != null;
    final nameChanged = targetName != "";

    return otherEndDatePicked ||
        otherStartDatePicked ||
        typePicked ||
        nameChanged;
  }

  @override
  List<Object?> get props => [
        selectedOption,
        viewIndex,
        startDate,
        endDate,
        updateFilterCount,
        fbPageType,
        targetName,
        downloadingStatus,
        currentUnit,
        subUnitsList,
        stepUnitsList,
      ];
}
