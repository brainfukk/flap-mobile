import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderScreen extends StatefulWidget {
  final dynamic nextPageScreen;
  final Function requestFunc;
  final dynamic body;

  const LoaderScreen({
    Key? key,
    required this.nextPageScreen,
    required this.requestFunc,
    required this.body,
  }) : super(key: key);

  @override
  _LoaderScreenState createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  @override
  Widget build(BuildContext context) {
    Future<http.Response> response =
        Function.apply(widget.requestFunc, widget.body);

    return const Scaffold(
      body: Center(
        child: SpinKitThreeBounce(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
