import 'dart:typed_data';

class UserProfile {
  String? nickname;
  String? gender;
  String? maritalStatus;
  String? country;
  String? city;
  List<String> interests = [];
  List<String> lifestyleTags = [];
  String? email;
  String? phone;
  bool privateAlbumLocked = true;
  Uint8List? avatarBytes;
  List<Uint8List> albumBytes = [];
}

class AppSession {
  static bool isGuest = false;
  static bool isRegistered = false;
  static UserProfile profile = UserProfile();
  static void resetGuest() {
    isGuest = false;
    isRegistered = false;
    profile = UserProfile();
  }
}
