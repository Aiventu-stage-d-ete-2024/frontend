
import 'package:flutter/material.dart';
import 'package:test/common/spash_screen/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});

  final SplashScreenController _controller = SplashScreenController();


  @override
  Widget build(BuildContext context) {

   // _appController.logout();

    return Scaffold(
      body: FutureBuilder(
        future: _controller.initSplash(),
        builder: (context,snap) {
          if(snap.connectionState == ConnectionState.done){
            WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/lauch',
                (Route<dynamic> route) => false,
              );
            });

          }
          return  Center(
            child: Image.asset(
              "assets/2000_61d80773f1c1c.webp",
              height: 100,
              width: 90,
            ),
          );
        }
      ),
    );
  }
}