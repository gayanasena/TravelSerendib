import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travelapp/features/home/data/model/user_table_model.dart';

class FirebaseServices {
  late FlutterSecureStorage secureStorage;

  FirebaseServices() {
    secureStorage = const FlutterSecureStorage();
  }

  String getUserId() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser?.uid ?? "";
    } else {
      return "";
    }
  }

  void setUserData({UserCredential? userCredintials}) async {
    late String uid;

    if (userCredintials != null) {
      uid = userCredintials.user?.uid ?? '';
    } else {
      uid = getUserId();
    }

    // Retrieve user data from Firebase Realtime Database
    UserModel? user = await getUserData(uid);

    if (user != null) {
      // Save user data in secure storage if user data is found
      await secureStorage.write(key: 'uid', value: user.uid);
      await secureStorage.write(
          key: 'username', value: "${user.firstName} ${user.lastName}");
      await secureStorage.write(key: 'country', value: user.country);
      await secureStorage.write(key: 'userEmail', value: user.email);
      await secureStorage.write(key: 'userImageUrl', value: user.imageUrl);

      print('User data saved to secure storage.');
    } else {
      print('User data not found.');
    }
  }

  Future<UserModel?> getUserData(String uid) async {
    try {
      // Reference to the specific user's data in Firebase Realtime Database
      DatabaseReference userRef = FirebaseDatabase.instance.ref('users/$uid');

      // Fetch the user data snapshot
      DatabaseEvent event = await userRef.once();

      if (event.snapshot.value != null) {
        // Convert snapshot to a Map and then to a UserModel
        Map<String, dynamic> userData =
            Map<String, dynamic>.from(event.snapshot.value as Map);
        return UserModel.fromMap(userData);
      } else {
        print('User not found.');
        return null;
      }
    } catch (error) {
      print('Failed to retrieve user data: $error');
      return null;
    }
  }

  Future<void> saveUserData(UserModel user) async {
    try {
      // Reference to the 'users' node in Firebase Realtime Database
      DatabaseReference usersRef =
          FirebaseDatabase.instance.ref('users/${user.uid}');

      // Save user data as a map using the toMap method in UserModel
      await usersRef.set(user.toMap()).then((_) {
        print('User data saved successfully');
      }).catchError((error) {
        print('User data saved faild, ${error.toString()}');
      });
      print('User data saved successfully');
    } catch (error) {
      print('Failed to save user data: $error');
    }
  }
}
