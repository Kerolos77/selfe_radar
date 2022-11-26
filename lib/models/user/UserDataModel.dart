

class UserDataModel {
  late String name;
  late String email;
  late String ID;
  late bool isVrify;
  late String password;
  late double lat;
  late double lng;
  late double speed;

  UserDataModel(
      this.name,
      this.email,
      this.ID,
      this.isVrify,
      this.password,
      this.lat,
      this.lng,
      this.speed);

  UserDataModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    ID = json['id'];
    isVrify = json['isvrify'];
    password = json['password'];
    lat = json['lat'];
    lng = json['lng'];
    speed = json['speed'];

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'id': ID,
      'isvrify': isVrify,
      "password": password,
      "lat": lat,
      "lng": lng,
      "speed": speed,

    };
  }
}
