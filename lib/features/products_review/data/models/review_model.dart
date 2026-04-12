class ReviewModel {
  final String id;
  final String firstName;
  final String lastName;
  final String? avatarUrl;
  final String comment;

  ReviewModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
    required this.comment,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id'] ?? '',
      firstName: json['user']?['first_name'] ?? '',
      lastName: json['user']?['last_name'] ?? '',
      avatarUrl: json['user']?['avatar_url'],
      comment: json['comment'] ?? '',
    );
  }
}