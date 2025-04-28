import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tambong/model/app_user_model.dart';

class ProfileService {
  Future<List<AppUser>> getAllUsers() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      List<AppUser> users = snapshot.docs.map((doc) {
        return AppUser.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      return users;
    } catch (e) {
      print('Error fetching all users: $e');
      return [];
    }
  }

  Future<AppUser?> getUserDataById(String userId, String email) async {
    try {
      // Reference to the user document
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Get the document
      DocumentSnapshot doc = await userDocRef.get();

      if (doc.exists) {
        // If the document exists, return the user data
        return AppUser.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        // If the document does not exist, create it with default data
        await userDocRef.set({
          'userId': userId,
          'email': email,
          'completeName': "",
          'age': "",
          'church': "",
          'position': "Member",
          'address': "",
          'image': "",
          'mobileNo': "",
          'isadmin': false,
        });

        // Return the newly created user data
        DocumentSnapshot newDoc = await userDocRef.get();
        return AppUser.fromMap(
            newDoc.data() as Map<String, dynamic>, newDoc.id);
      }
    } catch (e) {
      print('Error getting user data by ID: $e');
      return null;
    }
  }

  Future<bool> doesUserExist(String userId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      return doc.exists;
    } catch (e) {
      print("Error checking user existence: $e");
      return false;
    }
  }

  Future<void> saveUserData(AppUser user) async {
    try {
      final userData = user.toMap();
      await FirebaseFirestore.instance.collection('users').add(userData);
    } catch (e) {
      print("Error saving user data: $e");
      throw e;
    }
  }

  Future<void> updateUserProfile(String userId, AppUser user) async {
    try {
      final userData = user.toMap();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update(userData);
    } catch (e) {
      print("Error updating user data: $e");
      throw e;
    }
  }

  Future<void> updateUserField(
      String userId, String fieldName, dynamic value) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({fieldName: value});
    } catch (e) {
      print("Error updating user field: $e");
      throw Exception("Error updating uesr field $e");
    }
  }
}
