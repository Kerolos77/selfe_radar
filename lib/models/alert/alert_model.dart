class AlertData {
  late String name;
  late String id;
  late String currentSpeed;
  late String preSpeed;
  late String nationalID;
  late String carNumber;
  late String time;
  late String history;
  late String price;


  AlertData(
      this.name,
      this.id,
      this.currentSpeed,
      this.preSpeed,
      this.time,
      this.history,
      this.price,
      this.nationalID,
      this.carNumber);

  AlertData.fromJson(Map<String, dynamic> json) {
    currentSpeed = json['currentSpeed'];
    name = json['name'];
    id = json['id'];
    preSpeed = json['preSpeed'];
    nationalID = json['nationalID'];
    carNumber = json['carNumber'];
    time = json['time'];
    history = json['history'];
    price = json['price'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'id': id,
      "preSpeed": preSpeed,
      "currentSpeed": currentSpeed,
      "nationalID": nationalID,
      "carNumber": carNumber,
      "time": time,
      "history": history,
    };
  }
}