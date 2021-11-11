import 'package:flutter/material.dart';

class ScreenFour extends StatelessWidget {
  const ScreenFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Page 4"),
      ),
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/five');

                },
                child: Text("Tap to Go to -> Fifth Screen")),
          ],
        )),
      ),
    );
  }
}
