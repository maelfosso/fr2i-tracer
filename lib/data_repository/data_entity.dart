class DataEntity {
  final String name;
  final String id;
  final String sex;
  final int age;
  final String coords;

  DataEntity(this.id, this.name, this.sex, this.age, this.coords);

  @override
  int get hashCode =>
      name.hashCode ^ sex.hashCode ^ age.hashCode ^ coords.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataEntity &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          sex == other.sex &&
          age == other.age &&
          coords == other.coords &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'name': name,
      'sex': sex,
      'age': age,
      'coords': coords,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'DataEntity{name: $name, sex: $sex, age: $age, coords: $coords, id: $id}';
  }
}