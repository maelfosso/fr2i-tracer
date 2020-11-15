import 'package:tracer/models/models.dart';

class DataEntity {
  final String _id;
  final int originalId;
  final String name;
  final String sex;
  final int age;
  final String longitude;
  final String latitude;
  final String altitude;

  DataEntity(
    this._id,
    this.originalId,
    this.name, 
    this.sex, 
    this.age, 
    this.longitude,
    this.latitude,
    this.altitude
  );

  @override
  int get hashCode =>
    _id.hashCode ^ name.hashCode ^ sex.hashCode ^ age.hashCode ^ longitude.hashCode ^ latitude.hashCode ^ altitude.hashCode;

  factory DataEntity.fromMap(int _id, Map<String, dynamic> map) {
    return DataEntity(
      map['_id'],
      map['originalId'],
      map['name'],
      map['sex'],
      map['age'],
      map['longitude'],
      map['latitude'],
      map['altitude'],
    );
  }

  Map<String, Object> toMap() {
    return {
      'originalId': 'originalId',
      'name': name,
      'sex': sex,
      'age': age,
      'longitude': longitude,
      'latitude': latitude,
      'altitude': altitude,
      '_id': _id,
    };
  }

  Data toData() {
    return Data(
      name,
      sex,
      age,
      longitude,
      latitude,
      altitude,
      originalId,
      state: this._id.isNotEmpty ? VisibilityFilter.synchronized : VisibilityFilter.notsynchronized
    );
  }

  static DataEntity fromJson(Map<String, Object> json) {
    return DataEntity(
      json['_id'] as String,
      json['originalId'] as int,
      json['name'] as String,
      json['sex'] as String,
      json['age'] as int,
      json['longitude'] as String,
      json['latitude'] as String,
      json['altitude'] as String,
    );
  }

  @override
  String toString() {
    return 'DataEntity{originalId: $originalId, name: $name, sex: $sex, age: $age, longitude: $longitude, latitude: $latitude, altitude: $altitude, _id: $_id}';
  }
}