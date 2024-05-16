import 'package:api_client/api_client.dart';
import 'package:target_repository/src/models/models.dart';

const subjectLimit = 20;

class TargetRepository {
  TargetRepository({TargetApiClient? targetApiClient})
      : _targetApiClient = targetApiClient ?? TargetApiClient();

  final TargetApiClient _targetApiClient;

  Future<TargetOverall> getOverall() async {
    final result = await _targetApiClient.getOverall();

    return TargetOverall.fromJson(result);
  }

  Future<List<Subject>> fetchSubjects(int typeAc, [int length = 0]) async {
    final result = await _targetApiClient.fetchSubjects(
      typeAc,
      subjectLimit,
      (length / subjectLimit).ceil() + 1,
    );

    return result.map((e) => Subject.fromJson(e)).toList();
  }

  Future<Subject> fetchSubjectById(String subjectId) async {
    final result = await _targetApiClient.fetchSubjectById(subjectId);

    return Subject.fromJson(result);
  }

  Future<void> createSubject(
      String infoName, String type, String typeAc, String uid) async {
    await _targetApiClient.createSubject(infoName, type, typeAc, uid);
  }

  Future<List<Post>> fetchPosts(String subjectId, [int length = 0]) async {
    final result = await _targetApiClient.fetchPosts(
      subjectId,
      subjectLimit,
      (length / subjectLimit).ceil() + 1,
    );

    return result.map((e) => Post.fromJson(e)).toList();
  }
}
