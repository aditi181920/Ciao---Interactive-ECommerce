import 'dart:typed_data';

import 'package:app1/providers/user_social_detail.dart';
import 'package:app1/services/loginuser.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app1/utils/utils.dart';
import 'package:provider/provider.dart';

class postAdd extends StatefulWidget {
  const postAdd({Key? key}) : super(key: key);

  @override
  State<postAdd> createState() => _postAddState();
}

class _postAddState extends State<postAdd> {
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _file;
  _selectImage(BuildContext parentcontext) async {
    return showDialog(
      context: parentcontext,
      builder: (context) {
        return SimpleDialog(
          title: Text('Create a Post'),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Pick from gallery'),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List file = await Utils().pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Cancel'),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void postImage(String uid, String username) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FireCloud().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        Utils().showSnackBar(context: context, content: 'Posted!');
        clearImage();
      } else {
        Utils().showSnackBar(context: context, content: res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      Utils().showSnackBar(context: context, content: err.toString());
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserSocialProvider userprov =
        Provider.of<UserSocialProvider>(context,listen: false);
    return _file == null
        ? Center(
            child: IconButton(
              icon: Icon(Icons.upload),
              onPressed: () {
                _selectImage(context);
              },
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurpleAccent.withOpacity(0.5),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  clearImage();
                },
              ),
              title: Text('Post to'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () {
                    postImage(
                      userprov.user!.uid,
                      userprov.user!.username,
                    );
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0.0)),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              hintText: 'Write a caption...',
                              border: InputBorder.none,
                            ),
                            maxLines: 8,
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
              ],
            ),
          );
  }
}
