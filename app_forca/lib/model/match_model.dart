class MatchModel {

  MatchModel({
    required this.id,
    required this.result,
  });

  String id;
  int result;

  @override
  String toString() {
    return '$id : $result';
  }
}