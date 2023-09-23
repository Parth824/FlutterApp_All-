import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class OrderDeliveryPage extends StatefulWidget {
  const OrderDeliveryPage({super.key});

  static String routeName = "/orderdelivery";

  @override
  State<OrderDeliveryPage> createState() => _OrderDeliveryPageState();
}

class _OrderDeliveryPageState extends State<OrderDeliveryPage> {
  GlobalKey<FormState> imsertformKey = GlobalKey<FormState>();
  String date = DateTime.now().toString().split(" ")[0];

  String? name;

  TextEditingController nameController = TextEditingController();

  File? _image;
  ImagePicker pick = ImagePicker();

  getImageFromCamera() async {
    XFile? xfile = await pick.pickImage(source: ImageSource.camera);
    String path = xfile!.path;
    setState(() {
      _image = File(path);
    });
  }

  getImageFromGallery() async {
    XFile? xfile = await pick.pickImage(source: ImageSource.gallery);
    String path = xfile!.path;
    setState(() {
      _image = File(path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Item : $index",
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),

                      FloatingActionButton.extended(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 280,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          IconButton(onPressed: () {
                                            if(_image != null) {
                                              _image = null;
                                              Navigator.of(context).pop();
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                      content: Text('Please Submit Report...'),
                                                      backgroundColor: Colors.green,
                                                      elevation: 10,
                                                      behavior: SnackBarBehavior.floating,
                                                      margin: EdgeInsets.all(5),
                                              ),);
                                            }
                                          }, icon: Icon(Icons.done_outline_rounded,size: 30,color: Colors.green,)),
                                        ],
                                      ),
                                      Text("Item : $index"),
                                      SizedBox(height: 10,),
                                      StreamBuilder(
                                          builder: (context, builder) {
                                            return Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(100)),
                                              child:(_image != null) ?
                                              CircleAvatar(
                                                radius: 55,
                                                backgroundImage: (_image != null)
                                                    ? FileImage(_image!)
                                                    : null,
                                              ) : CircleAvatar(
                                                radius: 55,
                                                backgroundColor: Colors.white,
                                                child: Icon(Icons.add_a_photo_outlined),
                                              ),
                                            );
                                          }
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Card(
                                              elevation: 3,
                                              child: TextButton(
                                                  onPressed: () {
                                                    getImageFromCamera();
                                                    setState(() {

                                                    });
                                                  },
                                                  child: Text(
                                                    "Camera",
                                                    style: TextStyle(
                                                        letterSpacing: 2,
                                                        fontSize: 18),
                                                  ))),
                                          SizedBox(width: 20),
                                          Card(
                                              elevation: 3,
                                              child: TextButton(
                                                  onPressed: () {
                                                    getImageFromGallery();
                                                    setState(() {

                                                    });
                                                  },
                                                  child: Text(
                                                    "Gallery",
                                                    style: TextStyle(
                                                        letterSpacing: 2,
                                                        fontSize: 18),
                                                  ))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        backgroundColor: Colors.blue[400],
                        icon: Icon(Icons.add),
                        label: Text(
                          "Report",
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      // IconButton(onPressed: () {}, icon: Icon(Icons.report,color: Colors.green,size: 30,))
                    ],
                  ),
                ),
              ),
            );
          }),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {
      //       InsertAndValidate();
      //     },
      //   icon: Icon(Icons.add),
      //   label: Text("Order",style: TextStyle(fontSize: 19),),
      // ),
    );
  }

// InsertAndValidate() {
//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (all) => AlertDialog(
//       backgroundColor: Colors.grey[200],
//       content: Form(
//         key: imsertformKey,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(
//                 height: 15,
//               ),
//               Text("${date}"),
//               SizedBox(
//                 height: 15,
//               ),
//               StatefulBuilder(
//                 builder: (context, setState) {
//                   return Column(
//                     children: [
//                       ElevatedButton(
//                         onPressed: () async {
//                           getImageFromGallary();
//                           setState(() {
//                           });
//                         },
//                         child: Text("Upload Book Image"),
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       GestureDetector(
//                         onTap: () async {
//                            getImageFromGallary();
//                           setState(() {
//
//                           });
//                         },
//                         child: Card(
//                           elevation: 5,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(100)),
//                           child:(_image != null) ?
//                              CircleAvatar(
//                               radius: 55,
//                               backgroundImage: (_image != null)
//                               ? FileImage(_image!)
//                               : null,
//                               ) : CircleAvatar(
//                               radius: 55,
//                              backgroundColor: Colors.white,
//                             child: Icon(Icons.add_a_photo_outlined),
//                               ),
//                             ),
//                           ),
//                     ],
//                   );
//                 },
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Card(
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20)),
//                 child: TextFormField(
//                   controller: nameController,
//                   textInputAction: TextInputAction.next,
//                   validator: (val) {
//                     if (val!.isEmpty) {
//                       return "Enter name...";
//                     }
//                   },
//                   onSaved: (val) {
//                     setState(() {
//                       name = val;
//                     });
//                   },
//                   decoration: InputDecoration(
//                       hintText: "Printer name",
//                       hintStyle: TextStyle(color: Colors.grey[400]),
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       )),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       actions: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             OutlinedButton(
//                 onPressed: () {
//                   nameController.clear();
//
//                   setState(() {
//                     name = null;
//                   });
//
//                   Navigator.pop(context);
//                 },
//                 child: Text("Cancel")),
//             SizedBox(
//               width: 20,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 if (imsertformKey.currentState!.validate()) {
//                   imsertformKey.currentState!.save();
//
//                   Map<String, dynamic> data = {
//                     'name': name,
//                     'date': date,
//                     'image': _image,
//                   };
//
//                   Navigator.of(context).pop();
//
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text("Record inserted successfully..."),
//                       backgroundColor: Colors.green,
//                       behavior: SnackBarBehavior.floating,
//                     ),
//                   );
//                   print("validate successfully...");
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text("Record insertion failed"),
//                       backgroundColor: Colors.red,
//                       behavior: SnackBarBehavior.floating,
//                     ),
//                   );
//                 }
//
//                 nameController.clear();
//
//                 setState(() {
//                   name = null;
//                 });
//               },
//               child: Text("Apply"),
//             ),
//           ],
//         )
//       ],
//     ),
//   );
// }
}