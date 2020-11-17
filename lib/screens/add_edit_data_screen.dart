import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracer/blocs/data/data_bloc.dart';
import 'package:tracer/blocs/data/data_event.dart';
import 'package:tracer/blocs/data/data_state.dart';
import 'package:tracer/models/models.dart';
import 'package:tracer/screens/keys.dart';

typedef OnSaveCallback = Function(
  String name, 
  String sex, 
  int age, 
  String longitute, String latitude, String altitude, 
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
  String _longitude;
  String _latitude;
  String _altitude;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? "Edit Data" : "Add Data",
        ),
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
                style: textTheme.headline5,
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
                initialValue: isEditing ? widget.data.age : '',
                key: ArchSampleKeys.nameField,
                autofocus: !isEditing,
                style: textTheme.headline5,
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
                initialValue: isEditing ? widget.data.longitude : '',
                key: ArchSampleKeys.longituteField,
                style: textTheme.subtitle1,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: "Longitude",
                  labelText: "Longitude"
                ),
                onSaved: (value) => _longitude = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.data.latitude : '',
                key: ArchSampleKeys.latitudeField,
                style: textTheme.subtitle1,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: "Latitude",
                  labelText: "Latitude"
                ),
                onSaved: (value) => _latitude = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.data.altitude : '',
                key: ArchSampleKeys.altitudeField,
                style: textTheme.subtitle1,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: "Altitude",
                  labelText: "Altitude"
                ),
                onSaved: (value) => _altitude = value,
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
            widget.onSave(_name, _sex, 0, _longitude, _latitude, _altitude, isEditing? widget.data.id : 0);
            Navigator.pop(context);
          }
        },
      ),
    ); 
  }
}
