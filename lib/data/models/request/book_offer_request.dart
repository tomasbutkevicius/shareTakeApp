class BookOfferRequest {
  final String userId;
  final String bookId;

  const BookOfferRequest({
    required this.userId,
    required this.bookId,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'bookId': this.bookId,
    };
  }

  factory BookOfferRequest.fromMap(Map<String, dynamic> map) {
    return BookOfferRequest(
      userId: map['userId'] as String,
      bookId: map['bookId'] as String,
    );
  }
}