import 'package:farmer/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:farmer/helper/UserHelper.dart';

class UploadImage extends StatefulWidget {
  UploadImage() : super();

  final String title = "Upload Image ";

  @override
  UploadImageState createState() => UploadImageState();
}

class UploadImageState extends State<UploadImage> {
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Lỗi ảnh tải lên';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload(String id) {
    setStatus('Đang tải lên...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName,id);
  }

  upload(String filename,String iduser) {
    UserHelper.sendImageUser(
        context,
        iduser,
        base64Image,
        filename
    );

  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Lỗi chọn ảnh',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'Không có ảnh',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    UserInf userInf;
    userInf=Provider.of<User>(context).getUserInf();
    String iduser = userInf.iduser.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Tải lên"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            OutlineButton(
              onPressed: chooseImage,
              child: Text('Chọn ảnh '),
            ),
            SizedBox(
              height: 20.0,
            ),
            showImage(),
            SizedBox(
              height: 20.0,
            ),
            OutlineButton(
              onPressed: (){
                startUpload(iduser);
              },
              child: Text('Tải lên'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}