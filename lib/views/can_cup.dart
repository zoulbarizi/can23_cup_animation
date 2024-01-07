import 'package:can23_cup_animation/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CanCup extends StatefulWidget {
  const CanCup({super.key});

  @override
  State<CanCup> createState() => _CanCupState();
}

class _CanCupState extends State<CanCup> with TickerProviderStateMixin {
  late AnimationController cupAnimateCtrl;
  bool animateAkwabaText = false;
  bool animated = false;

  @override
  void initState() {
    super.initState();
    cupAnimateCtrl = AnimationController(vsync: this);
    cupAnimateCtrl.addListener(() {
      if (cupAnimateCtrl.value > 0.7) {
        cupAnimateCtrl.stop();
        animated = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          animateAkwabaText = true;
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    cupAnimateCtrl.dispose();
  }

  topContent(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: !animated,
            child: Center(
              child: Lottie.asset(
                'assets/json/Can23_cup.json',
                controller: cupAnimateCtrl,
                onLoaded: (composition) {
                  cupAnimateCtrl
                    ..duration = composition.duration
                    ..forward();
                },
              ),
            ),
          ),
          if (animated) ...[
            Padding(
              padding: const EdgeInsets.all(30),
              child: Image.asset(
                'assets/images/cup_can.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 0),
            akwabaText(),
            slogan(),
          ]
        ],
      ),
    );
  }

  akwabaText() {
    return AnimatedOpacity(
      opacity: animateAkwabaText ? 1 : 0,
      duration: const Duration(seconds: 1),
      child: Text(
        'Akwaba !',
        style: GoogleFonts.dancingScript(
          fontSize: 50,
          height: .5,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  slogan() {
    return AnimatedOpacity(
      opacity: animateAkwabaText ? 1 : 0,
      duration: const Duration(seconds: 1),
      child: Text(
        "La CAN de l'hospitalité !",
        style: GoogleFonts.lemon(
          fontSize: 20,
          color: Consts.color2,
        ),
      ),
    );
  }

  bottomContent(Size size) {
    return Image.asset(
      "assets/images/can_equipes.jpeg",
      fit: BoxFit.fitWidth,
      width: size.width,
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ));
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      body: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            height: animated ? size.height * .62 : size.height,
            decoration: BoxDecoration(
              color: animated ? Consts.color1 : Colors.white,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(animated ? 40.0 : 0.0)),
            ),
            child: topContent(size),
          ),
          if (animated) ...[
            Expanded(child: bottomContent(size)),
            const SizedBox(height: 30),
          ],
        ],
      ),
    );
  }
}
