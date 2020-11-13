class DataEntity {
  final String id;
  final String name;
  final String sex;
  final int age;
  final String longitude;
  final String latitude;
  final String altitude;

  DataEntity(
    this.id,
    this.name, 
    this.sex, 
    this.age, 
    this.longitude,
    this.latitude,
    this.altitude
  );

  @override
  int get hashCode =>
      name.hashCode ^ sex.hashCode ^ age.hashCode ^ longitude.hashCode ^ latitude.hashCode ^ altitude.hashCode;


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataEntity &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          sex == other.sex &&
          age == other.age &&
          longitude == other.longitude &&
          latitude == other.latitude &&
          altitude == other.altitude &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'name': name,
      'sex': sex,
      'age': age,
      'longitude': longitude,
      'latitude': latitude,
      'altitude': altitude,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'DataEntity{name: $name, sex: $sex, age: $age, longitude: $longitude, latitude: $latitude, altitude: $altitude, id: $id}';
  }

  static DataEntity fromJson(Map<String, Object> json) {
    return DataEntity(
      json['id'] as String,
      json['name'] as String,
      json['sex'] as String,
      json['age'] as int,
      json['longitude'] as String,
      json['latitude'] as String,
      json['altitude'] as String,
    );
  }
}