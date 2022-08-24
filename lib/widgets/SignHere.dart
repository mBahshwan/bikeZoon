import 'package:signature/signature.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';

class SignHere extends StatefulWidget {
  const SignHere({
    Key? key,
  }) : super(key: key);

  @override
  State<SignHere> createState() => _SignHereState();
}

SignatureController signatureController = SignatureController(
    penStrokeWidth: 2,
    exportBackgroundColor: Colors.grey,
    penColor: Colors.black);

class _SignHereState extends State<SignHere> {
  @override
  Widget build(BuildContext context) {
    return Signature(
      controller: signatureController as SignatureController,
      backgroundColor: Colors.white,
      height: 80,
      width: 130,
    );
  }
}
