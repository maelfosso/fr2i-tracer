import 'dart:math';
import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final String name;
  final String sex;
  final int age;
  final String coords;
  final String id;

  Data(
    this.name, 
    this.sex, 
    this.age, 
    this.coords , {
      String id
    }
  ) : this.id = id ?? Uuid().generateV4();

  Data copyWith({String name, String sex, int id, String coords}) {
    return Data(
      name ?? this.name,
      sex ?? this.sex,
      age ?? this.age,
      coords ?? this.coords,
      id: id ?? this.id,
    );
  }

  @override
  int get hashCode =>
      name.hashCode ^ sex.hashCode ^ age.hashCode ^ coords.hashCode;

  @override
  List<Object> get props => [id, name, age, sex, coords];

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

  static Data fromEntity(DataEntity entity) {
    return Data(
      entity.name,
      entity.sex,
      entity.age,
      entity.coords,
      id: entity.id ?? Uuid().generateV4(),
    );
  }

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

class Uuid {
  final Random _random = Random();

  String generateV4() {
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}
