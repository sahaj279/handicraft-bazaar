class Rating {
  final String userId;
  final double rating;

  Rating({required this.userId, required this.rating});

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      rating:double.parse( map['rating'].toString()),//this maybe stored in double
      userId: map['userId'],
    );
  }

  Map<String, dynamic> toMap(Rating rating) {
    return {
      'rating': rating.rating,
      'userId': rating.userId,
    };
  }
}
