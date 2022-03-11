import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadFile(
    String filePath,
    String fileName,
    String uploadPath,
  ) async {
    File file = File(filePath);

    try {
      await storage.ref(uploadPath).putFile(file);
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<ListResult> listFiles() async {
    ListResult results = await storage.ref().listAll();

    results.items.forEach((element) {
      print("Found file: $element");
    });
    return results;
  }

  Future<String> getFileUrl(String filePath) async {
    Reference ref = storage.ref().child(filePath);
    return ref.getDownloadURL();
  }
}
