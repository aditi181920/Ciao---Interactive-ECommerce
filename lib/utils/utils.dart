import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Utils{
  showSnackBar({required BuildContext context,required String content}){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(content)
                ],
            ),
        ),
    );
  }

  pickImage(ImageSource source) async{
    final ImagePicker _imagePicker=ImagePicker();
    XFile? _file=await _imagePicker.pickImage(source: source);
    if(_file!=null){
      return await _file.readAsBytes();
    }
    print('No Image selected');
  }
}