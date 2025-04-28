import 'package:firebase_auth/firebase_auth.dart';
import 'package:tambong/enum/List_chuch_position.dart';
import 'package:tambong/home/home_view.dart';
import 'package:tambong/model/app_user_model.dart';
import 'package:tambong/profile/edit_profile/edit_profile_view.dart';
import 'package:tambong/profile/complete_profile/complete_profile_view.dart'; // Import CompleteProfileView
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import '../profile_service/profile_service.dart';

class ProfileViewModel extends BaseViewModel {
  final ProfileService profileService;
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final email = FirebaseAuth.instance.currentUser?.email;
  List<AppUser> _users = [];
  AppUser? _user;

  List<AppUser> get users => _users;
  AppUser? get user => _user;

  ProfileViewModel() : profileService = ProfileService() {
    checkUserAndFetchData();
  }

  Position selectedPosition = Position.Visitor;

  List<Position> get positionOptions => Position.values.toList();

  void updateSelectedPosition(Position? newPosition) {
    if (newPosition != null) {
      selectedPosition = newPosition;
      notifyListeners();
    }
  }

  Future<void> checkUserAndFetchData() async {
    setBusy(true);

    try {
      if (userId == null) {
        throw Exception("User ID is null");
      }

      // Check if user exists in Firestore
      bool userExists = await profileService.doesUserExist(userId!);
      if (userExists) {
        print("User exists, fetching data...");
        await fetchUser();
      } else {
        bool isEdit = true;
        print("User does not exist, redirecting to CompleteProfileView...");
        Get.to(() => CompleteProfileView(isEdit: isEdit));
      }
    } catch (e) {
      print("Error checking user existence: $e");
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  Future<void> fetchUser() async {
    try {
      print("Fetching user with ID: $userId");
      _user = await profileService.getUserDataById(userId!, email!);
      if (_user != null) {
        print("User fetched: ${_user!.completeName}");
      } else {
        print("No user found with ID: $userId");
      }
    } catch (e) {
      print("Error fetching user: $e");
    } finally {
      notifyListeners();
    }
  }

  void gotoEditProfile() {
    print("Going to EditProfileView");
    Get.to(() => EditProfileView(user: user!));
  }

  void gotoUpdateUserProfile(String userId) {
    if (_user != null) {
      profileService.updateUserProfile(userId, _user!);
    }
  }

  void goToHomePage() {
    Get.offAll(() => HomeView());
  }
}
