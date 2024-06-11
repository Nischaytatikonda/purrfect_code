/*
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../log/log.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var widthOffset = width * 0.66;
    var heightOffset = height * 0.5;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ui_images/purrfect_push_splash.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            SizedBox(height: heightOffset),
            Container(
              width: min(widthOffset, 600),
              height: 40,
              color: Colors.black54,
              child: TextField(
                  controller: textController,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: const InputDecoration(
                    labelText: 'Enter Password',
                  ),
                  obscureText: true,
                ),
              ),
            const SizedBox(height:40),
            SizedBox(
              width: 300.0,
              height: 50.0,
              child: OutlinedButton(
                style:  ButtonStyle(
                  side: WidgetStateProperty.all(const BorderSide(
                    color: Colors.black,
                    width: 2.0,
                    style: BorderStyle.solid)),
                  backgroundColor:
                    WidgetStateProperty.resolveWith<Color>((states) {
                      if (states.contains(WidgetState.disabled)) {
                        return Colors.transparent;
                      }
                      return Colors.lightBlue;
                    }
                  ),
                  overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.lightBlue;
                    }
                    return Colors.lightBlue;
                  }
                  ),
                ),
                onPressed: () {
                    //Navigator.pushNamed(context, 'game');
                    _validatePassword(textController.text, context);
                  },
                child: const Text(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                  ),
                  'Play Purrfect Push'),
                ),
            ),
          ],
        ),
      ),
    );
  }

  void _validatePassword(String text, BuildContext context)
  {
    final str = utf8.decode(base64.decode('OXFlaWJFS3JzVlZMMmppeWFpWWI='));
    logger.i('decoded string= $str, password= $text');
    if(text == str) {
      Navigator.pushNamed(context, 'Z2FtZQ==');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invalid Password'),
            actions: <Widget>[
              TextButton(
                child: const Text('Retry'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}

