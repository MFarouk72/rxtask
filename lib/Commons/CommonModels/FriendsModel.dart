class FriendsModel {
  int? _id;
  late String _firstName;
  late String _lastName;
  late String _email;
  late String _phone;
  late String _address;
  late String _gender;
  late String _imagePath;
  late String _lat;
  late String _long;

  FriendsModel(dynamic obj) {
    _id = obj['id'];
    _firstName = obj['firstName'];
    _lastName = obj['lastName'];
    _email = obj['email'];
    _phone = obj['phone'];
    _address = obj['address'];
    _gender = obj['gender'];
    _imagePath = obj['imagePath'];
    _lat = obj['lat'];
    _long = obj['long'];
  }

  FriendsModel.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _firstName = data['firstName'];
    _lastName = data['lastName'];
    _email = data['email'];
    _phone = data['phone'];
    _address = data['address'];
    _gender = data['gender'];
    _imagePath = data['imagePath'];
    _lat = data['lat'];
    _long = data['long'];
  }

  Map<String, dynamic> toMap() => {
        'id': _id,
        'firstName': _firstName,
        'lastName': _lastName,
        'email': _email,
        'phone': _phone,
        'address': _address,
        'gender': _gender,
        'imagePath': _imagePath,
        'lat': _lat,
        'long': _long,
      };

  int? get id => _id;

  String get firstName => _firstName;

  String get lastName => _lastName;

  String get email => _email;

  String get phone => _phone;

  String get address => _address;

  String get gender => _gender;

  String get imagePath => _imagePath;

  String get lat => _lat;

  String get long => _long;
}
