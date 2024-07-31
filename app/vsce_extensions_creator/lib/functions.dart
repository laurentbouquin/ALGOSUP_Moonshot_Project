import 'package:flutter/material.dart';

Row test(String name, List<String> values, int index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Text(name),
      DropdownButton(
        items: values.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        value: values[index],
        onChanged: (value) {
          print('DropdownButton Selected: $value');
        },
      ),
    ],
  );
}
