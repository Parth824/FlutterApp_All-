import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_base_firebase/helper/db_hlper.dart';
import 'package:login_base_firebase/helper/firbase_hlper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController namecontoroll = TextEditingController();
  TextEditingController agecontoroll = TextEditingController();
  TextEditingController cousercontoroll = TextEditingController();

  TextEditingController nameup = TextEditingController();
  TextEditingController ageup = TextEditingController();
  TextEditingController couserup = TextEditingController();

  String? name;
  int? age;
  String? couser;
  @override
  Widget build(BuildContext context) {
    User? user = ModalRoute.of(context)!.settings.arguments as User?;
    return Scaffold(
      appBar: AppBar(
        title: Text("Firbase App"),
        actions: [
          InkWell(
            onTap: () {
              Firbase_Hlper.fireHleper.Logout();

              Navigator.pushReplacementNamed(context, 'Login');
            },
            child: Icon(
              Icons.power_settings_new,
              size: 30,
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              radius: 80,
              foregroundImage: (user!.photoURL != null)
                  ? NetworkImage("${user.photoURL}")
                  : null,
            ),
            Divider(),
            (user!.isAnonymous)
                ? Text("Guste User")
                : (user.displayName != null)
                    ? Text("UserName: ${user.displayName}")
                    : Container(),
            (user!.isAnonymous) ? Container() : Text("EmailId: ${user.email}"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          InsertRecode();
        },
        label: Text("Insert"),
        icon: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: Dbhlper.db.collection('students').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Not Data Found...."),
            );
          }
          if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? dataall = snapshot.data;
            List<QueryDocumentSnapshot<Map<String, dynamic>>> datas =
                dataall!.docs;

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: datas.length,
                itemBuilder: (context, i) {
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      isThreeLine: true,
                      leading: Text(
                        "${i + 1}",
                      ),
                      title: Text(
                        "${datas[i]['name']}",
                      ),
                      subtitle: Text(
                        "${datas[i]['couser']}\nAge:${datas[i]['age']}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Update(k: datas[i].data(), id: datas[i].id);
                            },
                            icon: Icon(
                              Icons.edit,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Dbhlper.dbhlper.Delete(id: datas[i].id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "DELEDT Data Succffuly",
                                  ),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Update({required Map<String, dynamic> k, required String id}) {
    nameup.text = k['name'];
    ageup.text = k['age'].toString();
    couserup.text = k['couser'];

    name = k['name'];
    age = k['age'];
    couser = k['couser'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Recode"),
        content: Form(
          key: _globalKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameup,
                  onSaved: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter The Name..";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Name",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: ageup,
                  onSaved: (val) {
                    setState(() {
                      age = int.parse(val!);
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter The age..";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter age",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: couserup,
                  onSaved: (val) {
                    setState(() {
                      couser = val;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter The CouserName..";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Couser name",
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () async {
              if (_globalKey.currentState!.validate()) {
                _globalKey.currentState!.save();

                Map<String, dynamic> data = {
                  "name": name,
                  "age": age,
                  "couser": couser,
                };
                print(data);
                print(id);
                Dbhlper.dbhlper.update(id: id, k: data);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Updata Data Succffuly",
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
              setState(() {
                nameup.clear();
                couserup.clear();
                ageup.clear();

                name = "";
                couser = "";
                age = null;
              });
            },
            child: Text("UPDATA"),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                nameup.clear();
                couserup.clear();
                ageup.clear();

                name = "";
                couser = "";
                age = null;
              });
            },
            child: Text("Clear"),
          ),
        ],
      ),
    );
  }

  InsertRecode() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Insert Recode"),
        content: Form(
          key: _globalKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: namecontoroll,
                  onSaved: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter The Name..";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Name",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: agecontoroll,
                  onSaved: (val) {
                    setState(() {
                      age = int.parse(val!);
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter The age..";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter age",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: cousercontoroll,
                  onSaved: (val) {
                    setState(() {
                      couser = val;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter The CouserName..";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Couser name",
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              if (_globalKey.currentState!.validate()) {
                _globalKey.currentState!.save();

                Map<String, dynamic> data = {
                  "name": name,
                  "age": age,
                  "couser": couser
                };
                Dbhlper.dbhlper.insert(data: data);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Inser Data Succffuly",
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
              setState(() {
                namecontoroll.clear();
                cousercontoroll.clear();
                agecontoroll.clear();

                name = "";
                couser = "";
                age = null;
              });
            },
            child: Text("Add"),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                namecontoroll.clear();
                cousercontoroll.clear();
                agecontoroll.clear();

                name = "";
                couser = "";
                age = null;
              });
            },
            child: Text("Clear"),
          ),
        ],
      ),
    );
  }
}
