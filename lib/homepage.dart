import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double velocityValue = 0;
  double accelerationValue = 0;

  double ballX = 0;

  // settings
  bool appHasStarted = false;

  // start timer
  void startTimer() {
    appHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      updateVelocity();
      updateAcceleration();
    });
  }

  // velocity
  void updateVelocity() {
    setState(() {
      ballX += velocityValue / 400;
      if (ballX > 1.3) {
        ballX = -1.3;
      } else if (ballX < -1.3) {
        ballX = 1.3;
      }
    });
  }

  // acceleration
  void updateAcceleration() {
    setState(() {
      (velocityValue += accelerationValue / 100).round();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (appHasStarted == false) {
      startTimer();
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        color: Colors.grey[900],
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      'Basic Physics',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[200]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Developed by Amin',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 25
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'v = v + a*t',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[200]),
                    ),
                  ],
                )),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment(ballX, 0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const Divider(
                      height: 5,
                      color: Colors.white,
                      thickness: 5,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('v = ${velocityValue.round()} m/s',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20)),
                        // velocity slider
                        Slider(
                          min: 0,
                          max: 8,
                          activeColor: Colors.grey[500],
                          inactiveColor: Colors.grey[400],
                          //label: "$velocityValue",
                          value:
                              (velocityValue + 4) < 8 ? (velocityValue + 4) : 8,
                          divisions: 8,
                          onChanged: (newValue) {
                            setState(() {
                              velocityValue = newValue - 4;
                            });
                          },
                        ),
                        Text(
                          'V E L O C I T Y',
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 20),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('a = ${accelerationValue.round()} m/s2',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20)),
                        // acceleration slider
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Slider(
                            min: -1,
                            max: 10,
                            activeColor: Colors.green[500],
                            inactiveColor: Colors.green[300],
                            label: "$accelerationValue",
                            value: accelerationValue,
                            divisions: 11,
                            onChanged: (newValue) {
                              setState(() {
                                accelerationValue = newValue;
                              });
                            },
                          ),
                        ),
                        Text('A C C E L E R A T I O N',
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
