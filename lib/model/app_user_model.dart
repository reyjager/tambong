class AppUser {
  String userId;
  String email;
  String completeName;
  String? age;
  String? church;
  String? position;
  String? address;
  String? image;
  String mobileNo;
  bool? isadmin;

  AppUser(
      {required this.userId,
      required this.email,
      required this.completeName,
      this.age,
      this.church,
      this.position,
      this.address,
      this.image,
      required this.mobileNo,
      this.isadmin});

  factory AppUser.fromMap(Map<String, dynamic> data, String documentId) {
    return AppUser(
      userId: documentId,
      email: data['email'] ?? '',
      completeName: data['completeName'] ?? '',
      age: data['age'] ?? '',
      church: data['church'] ?? '',
      position: data['position'] ?? '',
      address: data['address'] ?? '',
      image: data['image'] ?? '',
      mobileNo: data['mobileNo'] ?? '',
      isadmin: data['isadmin'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': userId,
      'email': email,
      'firstName': completeName,
      'age': age,
      'church': church,
      'position': position,
      'address': address,
      'image': image,
      'mobileNo': mobileNo,
      'isadmin': isadmin,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': completeName,
      'age': age,
      'churchName': church,
      'position': position.toString(), // Or another format if needed
      'address': address,
      'mobileNo': mobileNo,
    };
  }
}
