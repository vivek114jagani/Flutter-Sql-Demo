import 'package:flutter/material.dart';
import 'package:localdatabase/helper/database_helper.dart';
import 'package:localdatabase/show_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper db = DatabaseHelper.instance;

  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController emailID = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // List<Map<String, dynamic>> fetchedData = [];

  @override
  void initState() {
    getDatabase();
    super.initState();
  }

  void getDatabase() async {
    await db.database;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: fName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "*field can't be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  label: const Text("First Name"),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: lName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "*field can't be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  label: const Text("Last Name"),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailID,
                validator: (value) {
                  RegExp regExp = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (value == null || value.isEmpty) {
                    return "*field can't be empty";
                  } else {
                    if (!regExp.hasMatch(value)) {
                      return "please, enter valid email address";
                    }
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  label: const Text("E-mali ID"),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final value = await db.insertData(
                            fName.text, lName.text, emailID.text);

                        print(value);
                      }
                    },
                    child: const Text("Insert"),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShowData(),
                        ),
                      );
                      // final value = await db.getData();

                      // value?.forEach((element) {
                      //   print(element);
                      // });

                      // setState(() {
                      //   fetchedData = value ?? [];
                      // });
                    },
                    child: const Text("Fetch"),
                  ),
                  TextButton(
                    onPressed: () async {
                      final value = await db.deleteTable();

                      print(value);
                    },
                    child: const Text("Table Delete"),
                  ),
                ],
              ),
              // const SizedBox(height: 30),
              // for (var data in fetchedData)
              //   Column(
              //     children: [
              //       Text("User ID: ${data['id']}"),
              //       Text("First Name: ${data['firstname']}"),
              //       Text("Last Name: ${data['lastname']}"),
              //       Text("Email: ${data['email']}"),
              //     ],
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
