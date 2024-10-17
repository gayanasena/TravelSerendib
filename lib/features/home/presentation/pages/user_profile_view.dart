import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travelapp/core/resources/colors.dart';
import 'package:travelapp/core/resources/text_styles.dart';
import 'package:travelapp/routes/routes.dart';
import 'package:travelapp/routes/routes_extension.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({
    super.key,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late FlutterSecureStorage secureStorage;
  late bool isLoggedIn = false;
  late String profileImageUrl = "";
  late String userName = " ";
  late String userEmail = "";

  @override
  void initState() {
    secureStorage = const FlutterSecureStorage();

    super.initState();
  }

  void setSecureStorageData() async {
    final username = await secureStorage.read(key: 'username') ?? '';
    final email = await secureStorage.read(key: 'userEmail') ?? '';
    final imageUrl = await secureStorage.read(key: 'userImageUrl') ?? '';

    // Update state only if necessary
    setState(() {
      userName = username;
      userEmail = email;
      profileImageUrl = imageUrl;
    });
  }

  void getSecureStorageData() async {
    if (await secureStorage.read(key: "isLoggedIn") == 'true') {
      setState(() {
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ApplicationColors(context).appWhiteBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          Center(
            child:profileImageUrl.isNotEmpty ? ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                profileImageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ) : Container(),
          ),
          const SizedBox(height: 16.0),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            userEmail,
            style: const TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 123, 123, 123),
            ),
          ),
          const SizedBox(height: 24.0),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.all(12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () async {
                  if (isLoggedIn) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Are you sure you want to log out?',
                          style: TextStyles(context).snackBarText,
                        ),
                        duration: const Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: primaryColor,
                        action: SnackBarAction(
                          label: 'Yes',
                          textColor: Colors.white,
                          onPressed: () async {
                            await FirebaseAuth.instance
                                .signOut()
                                .then((onValue) {
                              context.pushReplacementNamed(
                                  ScreenRoutes.toWelcomeScreen);

                              secureStorage.write(
                                  key: "isLoggedIn", value: 'false');
                            });
                          },
                        ),
                      ),
                    );
                  } else {
                    context.pushReplacementNamed(ScreenRoutes.toLoginScreen);
                  }
                },
                child: Text(
                  isLoggedIn ? 'Logout' : 'Login',
                  style: TextStyles(context).buttonText,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
