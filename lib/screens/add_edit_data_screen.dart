import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:tracer/models/models.dart';
import 'package:tracer/screens/keys.dart';

typedef OnSaveCallback = Function(
  String name, 
  String sex, 
  int age, 
  double longitude, double latitude, double altitude, 
  int id
);

class AddEditDataScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Data data;

  AddEditDataScreen({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.data,
  }) : super(key: key);

  @override
  _AddEditDataScreenState createState() => _AddEditDataScreenState();
}

class _AddEditDataScreenState extends State<AddEditDataScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name;
  String _sex = 'Male';
  int _age;

  double _longitude;
  double _latitude;
  double _altitude;

  bool get isEditing => widget.isEditing;
  
  TextEditingController _controllerLongitude;
  TextEditingController _controllerLatitude;
  TextEditingController _controllerAltitude;

  @override
  void initState() {
    super.initState();

    _controllerLongitude = new TextEditingController(text: isEditing ? widget.data.longitude.toString() : '');
    _controllerLatitude = new TextEditingController(text: isEditing ? widget.data.latitude.toString() : '');
    _controllerAltitude = new TextEditingController(text: isEditing ? widget.data.altitude.toString() : '');  
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? "Edit Data" : "Add Data",
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () async {
              print('\nGetting current location *** $_altitude - $_longitude - $_latitude');
              LocationData location = await Location.instance.getLocation();
              print('${location.altitude} - ${location.longitude} - ${location.latitude}');

              _controllerLongitude.text = location.longitude.toString();
              _controllerLatitude.text = location.latitude.toString();
              _controllerAltitude.text = location.altitude.toString();
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.data.name : '',
                key: ArchSampleKeys.nameField,
                autofocus: !isEditing,
                // style: textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: "Name",
                  labelText: "Name"
                ),
                validator: (val) {
                  return val.trim().isEmpty
                      ? "Name is empty"
                      : null;
                },
                onSaved: (value) => _name = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.data.age.toString() : '',
                key: ArchSampleKeys.nameField,
                autofocus: !isEditing,
                // style: textTheme.subtitle1,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  hintText: "Age",
                  labelText: "Age"
                ),
                validator: (val) {
                  return val.trim().isEmpty
                      ? "Age is empty"
                      : null;
                },
                onSaved: (value) => _age = int.parse(value)
              ),
              DropdownButtonFormField<String>(
                value: "Male",
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                onChanged: (String newValue) {
                  setState(() {
                    _sex = newValue;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Sex",
                  labelText: "Sex"
                ),
                items: <String>['Male', 'Female']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: _controllerLongitude,
                key: ArchSampleKeys.longituteField,
                // style: textTheme.subtitle1,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: "Longitude",
                  labelText: "Longitude"
                ),
                onSaved: (value) => _longitude = double.parse(value),
              ),
              TextFormField(
                // initialValue: isEditing ? widget.data.latitude.toString() : (_latitude == null ? '' : _latitude.toString()),
                controller: _controllerLatitude,
                key: ArchSampleKeys.latitudeField,
                // style: textTheme.subtitle1,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: "Latitude",
                  labelText: "Latitude"
                ),
                onSaved: (value) => _latitude = double.parse(value),
              ),
              TextFormField(
                // initialValue: isEditing ? widget.data.altitude.toString() : (_altitude == null ? '' : _altitude.toString()),
                controller: _controllerAltitude,
                key: ArchSampleKeys.altitudeField,
                // style: textTheme.subtitle1,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: "Altitude",
                  labelText: "Altitude"
                ),
                onSaved: (value) => _altitude = double.parse(value),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: isEditing ? ArchSampleKeys.saveEditedDataFab : ArchSampleKeys.saveNewDataFab,
        tooltip: isEditing ? "Save Changes" : "Add new data",
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_name, _sex, _age, _longitude, _latitude, _altitude, isEditing? widget.data.id : 0);
            Navigator.pop(context);
          }
        },
      ),
    ); 
  }
}
