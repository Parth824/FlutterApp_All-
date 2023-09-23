import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:rentapp/size_config.dart';
import 'package:rentapp/views/screens/Doctor/complain/cir_contoroller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import 'complaincontorller.dart';

class ComplainPage extends StatefulWidget {
  const ComplainPage({Key? key}) : super(key: key);
  static String routeName = "/complain";

  @override
  State<ComplainPage> createState() => _ComplainPageState();
}

class _ComplainPageState extends State<ComplainPage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController compalain = TextEditingController();
  @override
  File? NozelFile;
  File? imageFile;
  String Complain_Des = "";
  String nozelname = "";
  String imagename = "";
  Uint8List? NozelFile1;
  Uint8List? imageFile1;

  ComplainContoroller complainContoroller = Get.put(ComplainContoroller());

  CirController cirController = Get.put(CirController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Complain",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 1.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: globalKey,
                child: TextFormField(
                  controller: compalain,
                  onSaved: (val) {
                    Complain_Des = val!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter the Complain..";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Complain",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenHeight(25),
                      ),
                    ),
                    prefixIcon: Icon(Icons.newspaper),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Spacer(),
              Container(
                  height: MediaQuery.of(context).size.height / 6,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade600,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                      child: NozelFile == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _getNozelimage();
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        size: getProportionateScreenHeight(30),
                                      ),
                                      Text(
                                        "Add Nozel",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize:
                                              MediaQuery.of(context).size.height /
                                                  40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Container(
                              child: Image.file(
                                NozelFile!,
                                fit: BoxFit.cover,
                              ),
                            ))),
              const Spacer(),
              Container(
                  height: MediaQuery.of(context).size.height / 6,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                      child: imageFile == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _getFromGallery();
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        size: getProportionateScreenHeight(30),
                                      ),
                                      Text(
                                        "ADD IMAGE",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize:
                                              MediaQuery.of(context).size.height /
                                                  40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Container(
                              child: Image.file(
                                imageFile!,
                                fit: BoxFit.cover,
                              ),
                            ))),
              const Spacer(),
              Obx(
                () => Visibility(
                  visible: cirController.isloding.value,
                  child: CircularProgressIndicator(),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Row(
                children: [
                  Spacer(),
                  InkWell(
                    onTap: () {
                      NozelFile = null;
                      imageFile = null;
                      Complain_Des = "";
                      nozelname = "";
                      imagename = "";
                      NozelFile1 = null;
                      imageFile1 = null;
                      compalain.clear();
                      setState(() {});
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: Colors.red,
                      ),
                      child: const Center(
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () async {
                      if (globalKey.currentState!.validate()) {
                        globalKey.currentState!.save();
                        if (NozelFile != null && imageFile != null) {
                          cirController.setLoding(isl: true);
                          String? m = sharedPreferences.getString("Id");
                          Map k = {
                            "Printer_Name": '',
                            "D_Id": m,
                            "E_Id": 'null',
                            "Image": imageFile1,
                            "ImageName": imagename,
                            "Nozel_Check": NozelFile1,
                            "NozelName": nozelname,
                            "Description": Complain_Des
                          };
                          await complainContoroller.setComplain(k: k);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Send Request SuccessFully"),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ));
                          cirController.setLoding(isl: false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Add Nozel And Add Image..."),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ));
                        }
                      }
                      NozelFile = null;
                      imageFile = null;
                      Complain_Des = "";
                      nozelname = "";
                      imagename = "";
                      NozelFile1 = null;
                      imageFile1 = null;
                      compalain.clear();
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: Colors.green,
                      ),
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 18,
                      child: Center(
                        child: Text(
                          "SEND",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getNozelimage() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      NozelFile = File(pickedFile.path);
      NozelFile1 = await pickedFile.readAsBytes() as Uint8List;
      print(NozelFile1);
      nozelname = NozelFile!.path.split('/').last;
      print(nozelname);
      setState(() {});
    }
  }

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      imageFile1 = await pickedFile.readAsBytes() as Uint8List;
      print(imageFile1);
      imagename = imageFile!.path.split("/").last;
      print(imagename);
      setState(() {});
    }
  }
}
