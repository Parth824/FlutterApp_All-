import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchDropdown extends StatelessWidget {
  SearchDropdown({
    required this.onChangedFunction,
    required this.title,
    required this.dropdownList,
  });
  final Function onChangedFunction;
  final String title;
  final List<String> dropdownList;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 11,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(
        left: 25,
        right: 20.0,
      ),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Theme(
        data: ThemeData.dark(),
        child: DropdownSearch<String>(
          popupProps: PopupPropsMultiSelection.menu(
              showSelectedItems: true,
              // searchFieldProps: ,
              disabledItemFn: (String s) => s.startsWith('I'),
              title: Text(title)),
          items: dropdownList,

          // onFind: (String filter) async {
          //   var uri = Uri.https('findmybusapi.herokuapp.com', url);
          //   var response = await http.get(uri);
          //   var citiesInJson = jsonDecode(response.body);
          //   List<String> _cityList =
          //       citiesInJson != null ? List.from(citiesInJson) : null;
          //   List<String> sortedCitiesList = _cityList..sort();
          //   return sortedCitiesList;
          // },
          // dr: const InputDecoration(
          //   labelStyle: TextStyle(
          //     decoration: TextDecoration.underline,
          //     fontFamily: 'WorkSans',
          //     fontWeight: FontWeight.bold,
          //     fontSize: 18.0,
          //     color: Colors.white,
          //   ),
          // ),
          // mode: Mode.DIALOG,
          // label: title,
          // hint: dropdownList.isEmpty
          //     ? "Not Available"
          //     : "Please choose correct option",
          // showSearchBox: true,
          onChanged: onChangedFunction(),
          // cl: true,
          validator: (v) => v == null ? "required field" : null,
        ),
      ),
    );
  }
}
