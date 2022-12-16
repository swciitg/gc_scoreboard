import 'package:flutter/material.dart';
import 'drop_down_package.dart';
import '../themes/themes.dart';

class CustomDropDown extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      dropDownList: const [
        DropDownValueModel(name: 'Barak', value: "Barak"),
        DropDownValueModel(name: 'Brahmaputra', value: "Dhansiri"),
        DropDownValueModel(name: 'Dhansiri', value: "Dhansiri"),
        DropDownValueModel(name: 'Dibang', value: "Dibang"),
        DropDownValueModel(name: 'Dihing', value: "Dihing"),
        DropDownValueModel(name: 'Disang', value: "Disang"),
        DropDownValueModel(name: 'Kameng', value: "Kameng"),
        DropDownValueModel(name: 'Kapili', value: "Kapili"),
        DropDownValueModel(name: 'Lohit', value: "Lohit"),
        DropDownValueModel(name: 'Manas', value: "Manas"),
        DropDownValueModel(name: 'Married Scholars', value: "Married Scholars"),
        DropDownValueModel(name: 'Siang', value: "Siang"),
        DropDownValueModel(name: 'Subansiri', value: "Subansiri"),
        DropDownValueModel(name: 'Umiam', value: "Umiam"),
      ],
      clearIconProperty: IconProperty(color: Colors.grey,size: 18) ,
      
      listTextStyle: Themes.theme.textTheme.headline6,
      dropDownIconProperty: IconProperty(color: Colors.grey),
      textStyle: Themes.theme.textTheme.headline6,
      textFieldDecoration: InputDecoration(
        hintText: 'Select Hostel*',
        hintStyle: Themes.theme.textTheme.bodyText1,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Themes.theme.focusColor, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Themes.theme.focusColor, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
      ),
    );
  }
}
