import 'package:flutter/material.dart';

class ShowLoadingIndicator extends StatelessWidget {
  const ShowLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)=> const Center(
    child: CircularProgressIndicator(
      color: Colors.blue,
    ),
  );
}
