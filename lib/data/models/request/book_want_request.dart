class BookWantRequest {
  final String userId;
  final String bookId;

  const BookWantRequest({
    required this.userId,
    required this.bookId,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'bookId': this.bookId,
    };
  }

  factory BookWantRequest.fromMap(Map<String, dynamic> map) {
    return BookWantRequest(
      userId: map['userId'] as String,
      bookId: map['bookId'] as String,
    );
  }
}