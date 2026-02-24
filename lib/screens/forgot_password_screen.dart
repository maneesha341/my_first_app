import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  String verificationId = "";
  bool otpSent = false;
  bool verified = false;

  // 🔥 SEND OTP
  void sendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneController.text.trim(),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.message}")),
        );
      },
      codeSent: (String verId, int? resendToken) {
        setState(() {
          verificationId = verId;
          otpSent = true;
        });
      },
      codeAutoRetrievalTimeout: (String verId) {},
    );
  }

  // 🔥 VERIFY OTP
  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpController.text.trim(),
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() {
        verified = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP")),
      );
    }
  }

  // 🔥 SAVE NEW PASSWORD (Demo)
  void saveNewPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Password Updated Successfully")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password (OTP)")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // STEP 1 - PHONE
            if (!otpSent)
              Column(
                children: [
                  const Text(
                    "Enter your mobile number",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      hintText: "+91XXXXXXXXXX",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: sendOTP,
                    child: const Text("Send OTP"),
                  ),
                ],
              ),

            // STEP 2 - OTP
            if (otpSent && !verified)
              Column(
                children: [
                  const Text(
                    "Enter OTP",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: otpController,
                    decoration: const InputDecoration(
                      hintText: "Enter OTP",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: verifyOTP,
                    child: const Text("Verify OTP"),
                  ),
                ],
              ),

            // STEP 3 - NEW PASSWORD
            if (verified)
              Column(
                children: [
                  const Text(
                    "Enter New Password",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "New Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: saveNewPassword,
                    child: const Text("Save Password"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}