import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // adding image to firebase storage
  Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage
   //childname contains which decoument we want to post to .. in our case we want to post to post
    Reference ref =
    _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if(isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id); //create a new doc in users's folder
    }

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(
        file
    );

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}