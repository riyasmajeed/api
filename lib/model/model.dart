class modelClass {
  String? sId;
  String? name;
  String? age;
  String? position;
  String? salary;
  List<Details>? details;

  modelClass(
      {this.sId,
      this.name,
      this.age,
      this.position,
      this.salary,
      this.details});

  modelClass.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    age = json['age'];
    position = json['position'];
    salary = json['salary'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['age'] = this.age;
    data['position'] = this.position;
    data['salary'] = this.salary;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? engineNumber;
  String? price;
  List<String>? colors;

  Details({this.engineNumber, this.price, this.colors});

  Details.fromJson(Map<String, dynamic> json) {
    engineNumber = json['engineNumber'];
    price = json['price'];
    colors = json['colors'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['engineNumber'] = this.engineNumber;
    data['price'] = this.price;
    data['colors'] = this.colors;
    return data;
  }
}