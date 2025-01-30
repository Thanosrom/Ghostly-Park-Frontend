import 'package:flutter/material.dart';

class Circular_Indicator extends StatefulWidget {
  final bool isTransparent;
  const Circular_Indicator({Key? key, this.isTransparent = false})
      : super(key: key);
  @override
  _Circular_IndicatorState createState() => _Circular_IndicatorState();
}

class _Circular_IndicatorState extends State<Circular_Indicator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isTransparent ? Colors.transparent : Colors.black,
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
