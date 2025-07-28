import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maporia/constants/app_assets.dart';
import 'package:maporia/constants/app_colors.dart';
import 'package:maporia/models.dart/user_model.dart';

class UserProfileHeader extends StatefulWidget {
  final UserModel user;

  const UserProfileHeader({super.key, required this.user});

  @override
  State<UserProfileHeader> createState() => _UserProfileHeaderState();
}

class _UserProfileHeaderState extends State<UserProfileHeader> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  String getAvatar(String gender) {
    return gender == 'male' ? AppAssets.male : AppAssets.female;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.ivoryWhite,
              backgroundImage: _imageFile != null
                  ? FileImage(_imageFile!)
                  : AssetImage(getAvatar(widget.user.gender)) as ImageProvider,
            ),
            Positioned(
              bottom: 0,
              right: 4,
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.ivoryWhite,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.brown, width: 1.5),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: AppColors.brown,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}