import 'package:flutter/material.dart';
import 'package:gd5_c_1172/database/sql_helper.dart';
import 'package:gd5_c_1172/entity/employee.dart';

class InputPage extends StatefulWidget {
  const InputPage(
    {super.key,
    required this.title,
    required this.id,
    required this.name,
    required this.email,
    required this.kelamin
    }
  );

  final String? title, name, email, kelamin;
  final int? id;

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerKelamin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      controllerName.text = widget.name!;
      controllerEmail.text = widget.email!;
      controllerKelamin.text = widget.kelamin!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("INPUT EMPLOYEE"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: controllerName,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Name', 
            ),
          ),
          SizedBox(height: 24),
          TextField(
            controller: controllerEmail,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 48),
          TextField(
            controller: controllerKelamin,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Kelamin Anda'
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            child: Text('Save'),
            onPressed: () async {
              if (widget.id == null) {
                await addEmployee();
              } else {
                await editEmployee(widget.id!);
              }
              Navigator.pop(context);
            },
          )
        ],
      ));
  }
  Future<void> addEmployee() async {
    await SQLHelper.addEmployee(controllerName.text, controllerEmail.text, controllerKelamin.text);
  }

  Future<void> editEmployee(int id) async {
    await SQLHelper.editEmployee(id, controllerName.text, controllerEmail.text, controllerKelamin.text);
  }
}