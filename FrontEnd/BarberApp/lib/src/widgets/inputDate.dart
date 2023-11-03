import 'package:flutter/material.dart';

Widget inputData(
  TextEditingController inputNameController,
  BuildContext context,
  DateTime selectedDate,
  Function(DateTime) onDateSelected,
) {
  ThemeData customTheme = ThemeData();

  Future<void> _selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now()
    );

    if (picked != null && picked != selectedDate) {
      onDateSelected(picked);
    }

    FocusScope.of(context).requestFocus(new FocusNode());
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: TextFormField(
      onTap: _selectDate,
      readOnly: true,
      controller: inputNameController,
      style: customTheme.primaryTextTheme.headline6,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        prefixIcon: InkWell(
          onTap: _selectDate,
          child: Icon(
            Icons.calendar_today,
            color: Colors.white,
          ),
        ),
        hintStyle: TextStyle(color: Colors.white),
        hintText: 'Data de Nascimento',
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none),
        fillColor: Color.fromRGBO(35, 33, 41, 1),
        filled: true,
      ),
    ),
  );
}
