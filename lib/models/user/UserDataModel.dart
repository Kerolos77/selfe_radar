class UserDataModel {
  late String name;
  late String email;
  late String ID;
  late bool isVrify;
  late String password;
  late double lat;
  late double lng;
  late double speed;
  late String nationalID;
  late String carNumber;
  late String cardNumber;
  late String cardHolder;
  late int cardMonth;
  late int cardYear;
  late int cvv;

  UserDataModel(
      this.name,
      this.email,
      this.ID,
      this.isVrify,
      this.password,
      this.lat,
      this.lng,
      this.speed,
      this.nationalID,
      this.carNumber,
      this.cardNumber,
      this.cardHolder,
      this.cardMonth,
      this.cardYear,
      this.cvv);

  UserDataModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    ID = json['id'];
    isVrify = json['isvrify'];
    password = json['password'];
    lat = json['lat'];
    lng = json['lng'];
    speed = json['speed'];
    nationalID = json['nationalID'];
    carNumber = json['carNumber'];
    cardNumber = json['cardNumber'];
    cardHolder = json['cardHolder'];
    cardMonth = json['cardMonth'];
    cardYear = json['cardYear'];
    cvv = json['cvv'];
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
      "nationalID": nationalID,
      "carNumber": carNumber,
      "cardNumber": cardNumber,
      "cardHolder": cardHolder,
      "cardMonth": cardMonth,
      "cardYear": cardYear,
      "cvv": cvv
    };
  }
}
