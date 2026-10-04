import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskyapp/core/services/preferences_manger.dart';
import 'package:taskyapp/core/theme/theme_controler.dart';
import 'package:taskyapp/core/widgets/custom_svg_picture.dart';
import 'package:taskyapp/core/features/profile/user_details_screen.dart';
import 'package:taskyapp/core/features/welcome/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  late String motivationQuote;

  bool isLoading = true;
  String? userImagePath;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    setState(() {
      username = PreferencesManger().getString("username") ?? " ";
      motivationQuote =
          PreferencesManger().getString("motivationQuote") ??
          "One task at a time. One step closer.";
      isLoading = false;
      userImagePath = PreferencesManger().getString("user_Image");
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text(
                      "My profile",
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall!.copyWith(fontSize: 28),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,

                        children: [
                          CircleAvatar(
                            backgroundImage: userImagePath == null
                                ? AssetImage("assets/images/Avatar.png")
                                : FileImage(File(userImagePath!)),

                            radius: 60,
                            backgroundColor: Colors.transparent,
                          ),

                          Positioned(
                            bottom: 0,
                            right: 0,
                            //////imagepicker /////
                            child: GestureDetector(
                              onTap: () async {
                                showImageSourceDialog(context, (XFile file) {
                                  _saveImage(file);
                                  setState(() {
                                    userImagePath = file.path;
                                  });
                                });
                              },
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                                ),
                                child: Icon(Icons.camera_alt, size: 24),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        username,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      SizedBox(height: 4),
                      Text(
                        motivationQuote,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Profile Info",
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(fontSize: 16),
                ),
                SizedBox(height: 20),

                ListTile(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return UserDetailsScreen(
                            userName: username,
                            motivationQuote: motivationQuote,
                          );
                        },
                      ),
                    );
                    if (result != null && result == true) {
                      _loadUserData();
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text("User Details"),
                  leading: CustomSvgPicture(path: "assets/images/Icon1.svg"),

                  trailing: CustomSvgPicture(
                    path: "assets/images/arrowback.svg",
                  ),
                ),
                // SizedBox(height: 5),
                Divider(),
                ListTile(
                  onTap: () {},
                  contentPadding: EdgeInsets.zero,
                  title: Text("Dark Mode"),
                  leading: CustomSvgPicture(
                    path: "assets/images/Leading element.svg",
                  ),
                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeControler.themeNotifier,
                    builder: (context, value, child) {
                      return Switch(
                        value: value == ThemeMode.dark,
                        onChanged: (bool value) async {
                          ThemeControler.toggleTheme();
                        },
                      );
                    },
                  ),
                ),
                //SizedBox(height: 14),
                Divider(),
                ListTile(
                  onTap: () async {
                    PreferencesManger().remove("username");
                    PreferencesManger().remove("tasks");
                    PreferencesManger().remove("motivationQuote");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return WelcomeScreen();
                        },
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text("Log Out"),
                  leading: CustomSvgPicture(path: "assets/images/Icon.svg"),

                  trailing: CustomSvgPicture(
                    path: "assets/images/arrowback.svg",
                  ),
                ),
              ],
            ),
          );
  }

  void _saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    PreferencesManger().setString("user_Image", newFile.path);
  }
}

void showImageSourceDialog(
  BuildContext context,
  Function(XFile) onImageSelected,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('Choose Image Source', style: TextStyle(fontSize: 20)),
        children: [
          SimpleDialogOption(
            padding: EdgeInsets.all(16.0),
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (image != null) {
                onImageSelected(image);
              }
            },

            child: Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 8),
                Text('Take a photo'),
              ],
            ),
          ),
          SimpleDialogOption(
            padding: EdgeInsets.all(16.0),
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                onImageSelected(image);
              }
            },
            child: Row(
              children: [
                Icon(Icons.photo_library),
                SizedBox(width: 8),
                Text('Choose from gallery'),
              ],
            ),
          ),
        ],
      );
    },
  );
}
