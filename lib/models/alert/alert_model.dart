class AlertData {
  late String name;
  late String id;
  late String currentSpeed;
  late String preSpeed;
  late String nationalID;
  late String carNumber;
  late String history;
  late String price;
  late String docID;
  late String address;

  AlertData(this.name, this.id, this.currentSpeed, this.preSpeed, this.history,
      this.price, this.nationalID, this.carNumber, this.docID, this.address);

  AlertData.fromJson(Map<String, dynamic> json) {
    currentSpeed = json['currentSpeed'];
    name = json['name'];
    id = json['id'];
    preSpeed = json['preSpeed'];
    nationalID = json['nationalID'];
    carNumber = json['carNumber'];
    history = json['history'];
    price = json['price'];
    docID = json['docID'];
    address = json['address'];
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
      "history": history,
      "docID": docID,
      "address": address
    };
  }
}
