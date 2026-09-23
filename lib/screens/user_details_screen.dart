import 'package:flutter/material.dart';
import 'package:taskyapp/core/services/preferences_manger.dart';
import 'package:taskyapp/core/widgets/custom_text_form_field.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });
  final String userName;
  final String motivationQuote;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late final TextEditingController userNamecontroller;

  late final TextEditingController motivationQuoteController;

  final GlobalKey<FormState> _key = GlobalKey();
  @override
  void initState() {
    userNamecontroller = TextEditingController(text: widget.userName);
    motivationQuoteController = TextEditingController(
      text: widget.motivationQuote,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details", style: TextStyle(fontSize: 20)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextFormField(
                controller: userNamecontroller,
                hintText: "Usama Elgendy",
                title: "User Name",
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter User Name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              CustomTextFormField(
                controller: motivationQuoteController,
                hintText: "One task at a time. One step closer.",
                title: "Motivation Quote",
                maxLine: 5,
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    await PreferencesManger().setString(
                      "username",
                      userNamecontroller.value.text,
                    );
                    await PreferencesManger().setString(
                      "motivationQuote",
                      motivationQuoteController.value.text,
                    );

                    Navigator.pop(context, true);
                  }
                },
                child: Text(
                  "Save Changes",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
