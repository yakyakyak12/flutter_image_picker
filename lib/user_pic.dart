import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserPic extends StatefulWidget {

  const UserPic({Key? key}) : super(key: key);

  @override
  State<UserPic> createState() => _UserPicState();
}

class _UserPicState extends State<UserPic> {
  XFile? _image; //이미지를 담을 변수 선언
  String base64Image1 = "";

  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    print("imageSource에는 머가 있어? ${imageSource.name}");
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    print("pickedFile에는 머가 있어? ${File(_image!.path)}");

    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30, width: double.infinity),
            _buildPhotoArea(),
            SizedBox(
              height: 50,
            ),
            Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.teal[300], elevation: 0, minimumSize: Size(100, 50)),
                  child: Text(
                    "전송",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: ()  {
                    if (null != _image) {
                      //_image1가 null 이 아니라면
                      final bytes = File(_image!.path).readAsBytesSync(); //image 를 byte로 불러옴
                      base64Image1 = base64Encode(bytes); //불러온 byte를 base64 압축하여 base64Image1 변수에 저장 만약 null이였다면 가장 위에 선언된것처럼 공백으로 처리됨
                      print("base64Image1에의 값 ${base64Image1}");

                    }
                  },
                ))
          ]
      ),
    );
  }

  Widget _buildPhotoArea() {
    return _image != null
        ? Container(
      width: 300,
      height: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell( // 사진 클릭시
          onTap: (){
            getImage(ImageSource.gallery); // 갤러리 호출
          },
          child: Image.file(
            File(_image!.path), // 파일의 경로를 나타냄
            width: double.infinity, // 부모의 가로 크기에 맞추기
            height: double.infinity, // 부모의 세로 크기에 맞추기
            fit: BoxFit.cover, // 이미지를 가득 채우도록 설정
          ),
        ),
      ),
    )
        : Container(
        width: 300,
        height: 300,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // 테두리 둥근 정도 결정
            child: InkWell(
                onTap: () {
                  getImage(ImageSource.gallery);
                },
                child: Image.asset("assets/images/profile.jpg", width: 300, height: 300))
              //  Image.network(widget.imageUrl)
            )
      // Image.asset(imageUrl)))
    );
  }
}
