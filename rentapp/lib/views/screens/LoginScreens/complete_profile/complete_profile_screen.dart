import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../../../size_config.dart';
import '../../../../components/custom_suffix.dart';
import '../../../../components/default_button.dart';
import '../../../../components/form_error.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../otp/otp_screen.dart';
import 'package:get/get.dart';

import '../select_category/select_category_controller.dart';
import '../sign_up/sing_up_controller.dart';
import '../signin/cir_controller.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);
  static String routeName = '/complete_profile';

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  String? Hospital;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;

  void addError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  SingUpController singUpController = Get.put(SingUpController());
  CirController cirController = Get.put(CirController());
  Select_Cat_Controller select_cat_controller =
      Get.find<Select_Cat_Controller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Complete Profile"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                Text(
                  "Complete Profile",
                  style: headingStyle,
                ),
                Text(
                  "Complete your details or continue \nwith social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Visibility(
                            visible: select_cat_controller.isDoctor.value,
                            child: buildHospitalFormField()),
                        Visibility(
                          visible: select_cat_controller.isDoctor.value,
                          child: SizedBox(
                            height: getProportionateScreenHeight(30),
                          ),
                        ),
                        buildFirstNameFormField(),
                        SizedBox(
                          height: getProportionateScreenHeight(30),
                        ),
                        buildLastNameFormField(),
                        SizedBox(
                          height: getProportionateScreenHeight(30),
                        ),
                        buildPhoneNumberFormField(),
                        SizedBox(
                          height: getProportionateScreenHeight(30),
                        ),
                        buildAddressFormField(),
                        FormError(errors: errors),
                        SizedBox(
                          height: getProportionateScreenHeight(40),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: getProportionateScreenHeight(56),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(kPrimaryColor),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                cirController.setLoding(isl: true);
                                if (select_cat_controller.isDoctor.value) {
                                  singUpController.E_P.addAll({
                                    'Hospital_Name': Hospital,
                                    'First_Name': firstName,
                                    'Last_Name': lastName,
                                    'Phone_Number': phoneNumber,
                                    'Address': address,
                                    'Paper_Size': '',
                                    'Paper_Price': '0',
                                  });
                                  // print(singUpController.E_P.value);
                                  await singUpController.insertData(
                                      isDoctor:
                                          select_cat_controller.isDoctor.value,
                                      k: singUpController.E_P.value);
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    OtpScreen.routeName,
                                    (route) {
                                      return false;
                                    },
                                  );
                                } else {
                                  singUpController.E_P.addAll({
                                    'First_Name': firstName,
                                    'Last_Name': lastName,
                                    'Phone_Number': phoneNumber,
                                    'Address': address,
                                    'Salary': '0',
                                  });
                                  // print(singUpController.E_P.value);
                                  await singUpController.insertData(
                                      isDoctor:
                                          select_cat_controller.isDoctor.value,
                                      k: singUpController.E_P.value);
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    OtpScreen.routeName,
                                    (route) {
                                      return false;
                                    },
                                  );
                                }
                                cirController.setLoding(isl: false);
                              }
                            },
                            child: Obx(
                              () => cirController.isloding.value
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Continue",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(18),
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                Text(
                  "By continuing your confirm that you agree \nwith our Term and Condition",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: "Address",
        enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(getProportionateScreenHeight(25))),

        hintText: "Enter your address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSuffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "Phone Number",
        enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(getProportionateScreenHeight(25))),

        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(getProportionateScreenHeight(25))),

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "First Name",
        enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(getProportionateScreenHeight(25))),

        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildHospitalFormField() {
    return TextFormField(
      onSaved: (newValue) => Hospital = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "Hospital Name",
        enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(getProportionateScreenHeight(25))),

        hintText: "Enter your hospital name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
