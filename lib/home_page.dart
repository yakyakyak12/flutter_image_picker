import 'package:flutter/material.dart';
import 'package:flutter_image_picker/user_pic.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserPic(),
    );
  }
}
