import 'package:flutter/material.dart';

class ZDropDownMenu extends StatelessWidget {
  const ZDropDownMenu({
    super.key,
    required this.width,
    required this.registerCityController,
    required this.height,
  });

  final double width;
  final TextEditingController registerCityController;
  final double height;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      hintText: 'Select your city',
      helperText: 'Select your city',
      label: Text('City'),
      width: width * 0.7,
      onSelected: (value) {
        registerCityController.text = value ?? '';
      },
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(Color(0xffedf2f4)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 10)),
        shadowColor: WidgetStateProperty.all(Color(0xff545454).withAlpha(100)),
        elevation: WidgetStateProperty.all(10),
        alignment: Alignment.centerLeft,
        fixedSize: WidgetStateProperty.all(Size(width * 0.7, height * 0.2)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xff545454).withAlpha(100)),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w700,
          color: Color(0xff545454),
          fontSize: 18,
        ),
        hintStyle: TextStyle(color: Color(0xff545454).withAlpha(100)),
      ),
      dropdownMenuEntries: [
        DropdownMenuEntry(value: 'Auckland', label: 'Auckland'),
        DropdownMenuEntry(value: 'Christchurch', label: 'Christchurch'),
        DropdownMenuEntry(value: 'Wellington', label: 'Wellington'),
        DropdownMenuEntry(value: 'Hamilton', label: 'Hamilton'),
        DropdownMenuEntry(value: 'Tauranga', label: 'Tauranga'),
        DropdownMenuEntry(value: 'Napier-Hastings', label: 'Napier-Hastings'),
        DropdownMenuEntry(value: 'Nelson', label: 'Nelson'),
        DropdownMenuEntry(value: 'Palmerston North', label: 'Palmerston North'),
        DropdownMenuEntry(value: 'Rotorua', label: 'Rotorua'),
        DropdownMenuEntry(value: 'Whangarei', label: 'Whangarei'),
        DropdownMenuEntry(value: 'Invercargill', label: 'Invercargill'),
        DropdownMenuEntry(value: 'Dunedin', label: 'Dunedin'),
      ],
    );
  }
}
