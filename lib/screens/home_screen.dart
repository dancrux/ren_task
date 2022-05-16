import 'package:flutter/material.dart';
import 'package:ren_task/values/app_colors.dart';
import 'package:ren_task/values/size_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showPrintText = false;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 39,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showPrintText = true;
                    },
                    child: const Text('Print'),
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.resolveWith(
                            (states) => const Size(70, 28)),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => AppColors.mainColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)))),
                  ),
                ),
                Visibility(
                    visible: showPrintText,
                    child: Text('Printing Response in log'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
