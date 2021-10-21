import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_note/models/theme.dart';

class MyButon extends StatelessWidget {
  final String lable;
  final Function()? onTap;
  const MyButon({Key? key, required this.lable, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: bluishClr),
        child: Center(
          child: Text(
            lable,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
