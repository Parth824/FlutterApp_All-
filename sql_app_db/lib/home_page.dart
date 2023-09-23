import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sql_app_db/model/db_hlper.dart';
import 'package:sql_app_db/model/student.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController cousecontroller = TextEditingController();

  String? name;
  int? age;
  String? couse;
  Uint8List? image2;

  late Future<List<Student>> DataAll = DbHlper.dbHlper.fechatAll_recode();

  File? file;
  ImagePicker image = ImagePicker();

  @override
  void initState() {
    cretar();
  }

  getImage() async {}

  cretar() async {
    await DbHlper.dbHlper.create_datebase();

    DataAll = DbHlper.dbHlper.fechatAll_recode();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Managment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: DataAll,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Data Not Found..."),
              );
            }
            if (snapshot.hasData) {
              List<Student>? k = snapshot.data;

              return ListView.builder(
                itemCount: k!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: (k[index].image != null)
                          ? CircleAvatar(
                              radius: 35,
                              backgroundImage: MemoryImage(k[index].image),
                            )
                          : CircleAvatar(
                              radius: 35,
                            ),
                      title: Text("${k[index].name}"),
                      subtitle: Text(
                        "${k[index].couser}\nage: ${k[index].age}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              insertRecode1(k[index]);
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () async {
                              int s =
                                  await DbHlper.dbHlper.Deletesp(k[index].id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("DELETE Recode ${s}..."),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              setState(() {
                                DataAll = DbHlper.dbHlper.fechatAll_recode();
                              });
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          insertRecode();
        },
        label: Text("INSERT"),
        icon: Icon(Icons.add),
      ),
    );
  }

  insertRecode1(Student s) {
    namecontroller.text = s.name;
    agecontroller.text = s.age.toString();
    cousecontroller.text = s.couser;
    image2 = s.image;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text("UDATE DATA"),
          ),
          content: Form(
            key: _globalKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StatefulBuilder(
                    builder: (context, setState) {
                      return InkWell(
                        onTap: () async {
                          final image1 = await image.pickImage(
                            source: ImageSource.camera,
                            imageQuality: 50,
                          );
                          if (image1 != null) {
                            setState(() {
                              file = File(image1.path);
                              image2 = file!.readAsBytesSync();
                            });
                          }
                        },
                        child: (image2 != null)
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: MemoryImage(image2!),
                              )
                            : CircleAvatar(
                                radius: 50,
                              ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: namecontroller,
                    onSaved: (val) {
                      name = val;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the Name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter name",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: agecontroller,
                    onSaved: (val) {
                      age = int.parse(val!);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the age";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter age",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: cousecontroller,
                    onSaved: (val) {
                      couse = val;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the Couse";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter couser",
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (_globalKey.currentState!.validate()) {
                  _globalKey.currentState!.save();

                  int k = await DbHlper.dbHlper.UpdateRecode(
                      name: name!, age: age!, couser: couse!, id: s.id,image: image2!);
                  Navigator.pop(context);
                  print(k);
                  if (k != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("UPDATE Recode ${k}..."),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("UPDATE Faill..."),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }

                  setState(() {
                    namecontroller.clear();
                    agecontroller.clear();
                    cousecontroller.clear();

                    name = "";
                    age = null;
                    couse = "";
                    DataAll = DbHlper.dbHlper.fechatAll_recode();
                    image2 = null;
                  });
                } else {}
              },
              child: Text("UPDATE"),
            ),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                  namecontroller.clear();
                  agecontroller.clear();
                  cousecontroller.clear();

                  name = "";
                  age = null;
                  couse = "";
                  image2 = null;
                });
              },
              child: Text("Clanel"),
            ),
          ],
        );
      },
    );
  }

  insertRecode() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text("INSERT DATA"),
          ),
          content: Form(
            key: _globalKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StatefulBuilder(
                    builder: (context, setState) {
                      return InkWell(
                        onTap: () async {
                          final image1 = await image.pickImage(
                            source: ImageSource.camera,
                            imageQuality: 50,
                          );
                          if (image1 != null) {
                            setState(() {
                              file = File(image1.path);
                              image2 = file!.readAsBytesSync();
                            });
                          }
                        },
                        child: (image2 != null)
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: MemoryImage(image2!),
                              )
                            : CircleAvatar(
                                radius: 50,
                              ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: namecontroller,
                    onSaved: (val) {
                      name = val;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the Name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter name",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: agecontroller,
                    onSaved: (val) {
                      age = int.parse(val!);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the age";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter age",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: cousecontroller,
                    onSaved: (val) {
                      couse = val;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the Couse";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter couser",
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (_globalKey.currentState!.validate()) {
                  _globalKey.currentState!.save();

                  int k = await DbHlper.dbHlper.insert_recode(
                      name: name!, age: age!, couser: couse!, image: image2!);
                  Navigator.pop(context);
                  print(k);
                  if (k != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Insert Recode ${k}..."),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Insert Faill..."),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }

                  setState(() {
                    namecontroller.clear();
                    agecontroller.clear();
                    cousecontroller.clear();

                    name = "";
                    age = null;
                    couse = "";
                    image2 = null;
                    DataAll = DbHlper.dbHlper.fechatAll_recode();
                  });
                } else {}
              },
              child: Text("Ok"),
            ),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                  namecontroller.clear();
                  agecontroller.clear();
                  cousecontroller.clear();

                  name = "";
                  age = null;
                  couse = "";
                  image2 = null;
                });
              },
              child: Text("Clanel"),
            ),
          ],
        );
      },
    );
  }
}
