import 'dart:io';
import 'package:app1/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import '../services/crud.dart';
class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String authorName="", title="", desc="";

   File? selectedImage;
  bool _isLoading = false;
  CrudMethods crudMethods = new CrudMethods();

  Future getImage() async {
    XFile? image;
    image= await  Utils().pickImage(ImageSource.gallery);

    setState(() {
      selectedImage = image as File;
    });
  }

  uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });

      /// uploading image to firebase storage
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL().toString();
      print("this is url $downloadUrl");

      Map<String, String> blogMap = {
        "imgUrl": downloadUrl,
        "authorName": authorName,
        "title": title,
        "desc": desc
      };
      crudMethods.addData(blogMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.black,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              uploadBlog();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.file_upload)),
          )
        ],
      ),
      body: _isLoading
          ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  getImage();
                },
                child: selectedImage != null
                    ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.file(
                      selectedImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                    : Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: 170,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  width: MediaQuery.of(context).size.width,
                  child: Icon(
                    Icons.add_a_photo,
                    color: Colors.black45,
                  ),
                )),
            SizedBox(
              height: 8,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: "Author Name"),
                    onChanged: (val) {
                      authorName = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Title"),
                    onChanged: (val) {
                      title = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Desc"),
                    onChanged: (val) {
                      desc = val;
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}