import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskyapp/core/services/preferences_manger.dart';
import 'package:taskyapp/core/theme/theme_controler.dart';
import 'package:taskyapp/screens/user_details_screen.dart';
import 'package:taskyapp/screens/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  late String motivationQuote;

  bool isLoading = true;

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
                  child: Text(
                    "My profile",
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall!.copyWith(fontSize: 28),
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
                            backgroundImage: AssetImage(
                              "assets/images/Avatar.png",
                            ),
                            radius: 60,
                            backgroundColor: Colors.transparent,
                          ),

                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xff282828),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Color(0xfffffcfc),
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        username,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xfffffcfc),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        motivationQuote,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffc6c6c6),
                        ),
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
                  title: Text(
                    "User Details",
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall!.copyWith(fontSize: 16),
                  ),
                  leading: SvgPicture.asset("assets/images/Icon1.svg"),
                  trailing: SvgPicture.asset("assets/images/arrowback.svg"),
                ),
                // SizedBox(height: 5),
                Divider(thickness: 1, color: Color(0xff6E6E6E)),
                ListTile(
                  onTap: () {},
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "Dark Mode",
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall!.copyWith(fontSize: 16),
                  ),
                  leading: SvgPicture.asset(
                    "assets/images/Leading element.svg",
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
                Divider(thickness: 1, color: Color(0xff6E6E6E)),
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
                  title: Text(
                    "Log Out",
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall!.copyWith(fontSize: 16),
                  ),
                  leading: SvgPicture.asset("assets/images/Icon.svg"),
                  trailing: SvgPicture.asset("assets/images/arrowback.svg"),
                ),
              ],
            ),
          );
  }
}
