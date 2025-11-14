import 'package:flutter/material.dart';
import 'package:esewa_flutter/esewa_flutter.dart';

class Esewapage extends StatefulWidget {
  const Esewapage({super.key});

  @override
  State<Esewapage> createState() => _EsewapageState();
}

class _EsewapageState extends State<Esewapage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          Container(
            child: EsewaPayButton(
              paymentConfig: ESewaConfig.dev(
                amount: 100.0,
                successUrl: 'https://developer.esewa.com.np/success',
                failureUrl: 'https://developer.esewa.com.np/failure',
                secretKey: 'YOUR_SECRET_KEY',
                // productCode: 'EPAYTEST', // optional for dev (defaults to EPAYTEST)
              ),
              onSuccess: (resp) {
                // resp.data is base64 string
                print('Success base64: ${resp.data}');
              },
              onFailure: (message) {
                print('Failed: $message');
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Inside a widget tree
