import 'package:api_client/api_client.dart';
import 'package:target_repository/src/models/models.dart';
import 'package:target_repository/src/models/post_overall.dart';

const subjectLimit = 20;

class TargetRepository {
  TargetRepository({TargetApiClient? targetApiClient})
      : _targetApiClient = targetApiClient ?? TargetApiClient();

  final TargetApiClient _targetApiClient;

  Future<TargetOverall> getOverall() async {
    final result = await _targetApiClient.getOverall();

    return TargetOverall.fromJson(result);
  }

  Future<PostOverall> getPostOverall() async {
    final result = await _targetApiClient.getPostOverall();

    return PostOverall.fromJson(result);
  }

  Future<List<Subject>> fetchSubjects(
      String unitId, int typeAc, String name, String? fbTypeId,
      [int length = 0]) async {
    final result = await _targetApiClient.fetchSubjects(
      unitId,
      typeAc,
      name,
      fbTypeId,
      subjectLimit,
      (length / subjectLimit).ceil() + 1,
    );

    return result.map((e) => Subject.fromJson(e)).toList();
  }

  Future<void> downloadExcelFile(
    int typeAc,
    String unitId,
    String startDate,
    String endDate,
    String path,
  ) async {
    await _targetApiClient.downloadFile(
      typeAc,
      unitId,
      startDate,
      endDate,
      path,
    );
  }

  Future<Subject> fetchSubjectById(String subjectId) async {
    final result = await _targetApiClient.fetchSubjectById(subjectId);

    return Subject.fromJson(result);
  }

  Future<void> createSubject(
      String infoName, String type, String typeAc, String uid) async {
    await _targetApiClient.createSubject(infoName, type, typeAc, uid);
  }

  Future<List<Post>> fetchPostsBySubjectId(String subjectId,
      [int length = 0]) async {
    final result = await _targetApiClient.fetchPostsBySubjectId(
      subjectId,
      subjectLimit,
      (length / subjectLimit).ceil() + 1,
    );

    return result.map((e) => Post.fromJson(e)).toList();
  }

  Future<List<Post>> fetchPostsByUnit(
      int typeAc, String unitId, String startDate, String endDate,
      [int length = 0]) async {
    final result = await _targetApiClient.fetchPostsByType(
      typeAc,
      unitId,
      startDate,
      endDate,
      subjectLimit,
      (length / subjectLimit).ceil() + 1,
    );

    return result.map((e) => Post.fromJson(e)).toList();
  }

  Future<void> deleteSubject(String subjectId) async {
    await _targetApiClient.deleteSubject(subjectId);
  }
}
