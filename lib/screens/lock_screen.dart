import 'package:admin_panel_aarogyam/screens/bottomNavBar.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({Key? key}) : super(key: key);

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  String enteredPin = '';
  bool correctPinEntered = false;

   _handleNumberClick(String number)async {
    setState(() {
      enteredPin += number;
    });

    if (enteredPin.length == 4) {
      if (enteredPin == '1234') {
        setState(() {
          correctPinEntered = true;
        });
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(),
          ),
        );

      } else {
        setState(() {
          enteredPin = '';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter the correct PIN'),backgroundColor: Colors.red,),
        );

      }
    }
  }

  void _handleDelete() {
    setState(() {
      if (enteredPin.isNotEmpty) {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  //IMage of aarogyam
                  child: Image.asset('assets/images/aarogyam.png',
                      width: 200, height: 100),
                ),
              ),
              const Text(
                'Enter  your admin PIN',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => _buildDot(index < enteredPin.length),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "——————————OR—————————",
                style: TextStyle(
                  color: Colors.green.shade800,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Unlock with your FINGERPRINT",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Center(
                child: Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Icon(Icons.fingerprint,size: 70,),
                ),
              ),
              const SizedBox(height: 80.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNumberButton('1'),
                  _buildNumberButton('2'),
                  _buildNumberButton('3'),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNumberButton('4'),
                  _buildNumberButton('5'),
                  _buildNumberButton('6'),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNumberButton('7'),
                  _buildNumberButton('8'),
                  _buildNumberButton('9'),
                ],
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildNumberButton('0'),
                    const SizedBox(
                      width: 42,
                    ),
                    _buildDeleteButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return SizedBox(
      height: 50,
      width: 75,
      child: ElevatedButton(
        onPressed: () => _handleNumberClick(number),
        child: Text(number),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return SizedBox(
      height: 50,
      width: 75,
      child: ElevatedButton(
        onPressed: _handleDelete,
        child: const Icon(Icons.backspace),
      ),
    );
  }

  Widget _buildDot(bool filled) {
    return Container(
      width: 25.0,
      height: 25.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? Colors.teal : Colors.transparent,
        border: Border.all(color: Colors.black),
      ),
    );
  }
}
