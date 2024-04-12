enum FetchDataStatus { initial, loading, success, failure }

extension FetchDataStatusX on FetchDataStatus {
  bool get isFailure => this == FetchDataStatus.failure;
  bool get isLoading => this == FetchDataStatus.loading;
  bool get isSuccess => this == FetchDataStatus.success;
}
