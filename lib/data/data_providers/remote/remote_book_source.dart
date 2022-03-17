import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_take/constants/api.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/request/add_book_request.dart';
import 'package:share_take/data/models/response/book_response.dart';

class RemoteBookSource {
  final FirebaseFirestore _fireStore;

  RemoteBookSource({
    FirebaseFirestore? fireStore,
  }) : _fireStore = fireStore ?? FirebaseFirestore.instance;

  Future<List<BookResponse>> getAllBooks() async {

    QuerySnapshot snapshot = await _fireStore.collection(StaticApi.booksCollection).get();


    return snapshot.docs.map((doc) => BookResponse.fromSnapshot(doc)).toList();
  }

  Future addBook(BookLocal book) async {
    final ByteData imageData = await NetworkAssetBundle(Uri.parse("YOUR_URL")).load("");
    final Uint8List bytes = imageData.buffer.asUint8List();

  }
}
