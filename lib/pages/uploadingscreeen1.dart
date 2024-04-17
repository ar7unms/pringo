import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:pringooo/pages/home.dart';
import 'package:pringooo/services/bindservices.dart';
import 'package:pringooo/services/transactionService.dart';
import 'package:pringooo/services/uploadservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

void main() {
  if (Platform.isAndroid) {
    // Execute Android-specific code
    print('Running on Android');
  } else if (Platform.isIOS) {
    // Execute iOS-specific code
    print('Running on iOS');
  } if (kIsWeb) {
    // Handle web-specific code
    print('Web platform detected');
  }
  else {
    // Handle unsupported platforms
    print('Unsupported platform');
  }
}

class uploadScreen extends StatefulWidget {
  const uploadScreen({super.key});

  @override
  State<uploadScreen> createState() => _uploadScreenState();
}

class _uploadScreenState extends State<uploadScreen> {
  Razorpay? _razorpay;
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Payment Success: ${response.paymentId}');
    print("success");
    // Handle payment success
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment Error: ${response.message}');
    print("success");
    // Handle payment error
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet: ${response.walletName}');
    print("success");
    // Handle external wallet
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay=Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet );
  }

  void initiatePayment(String amt) async {
    int am=int.parse(amt);
    amt=(am*100).toString();
    print("payemnt");
    var options = {
      'key': 'rzp_test_TtSDhSH3AFn8Su',
      'amount': amt, // Payment amount in paisa (e.g., 10000 for ₹100)
      'name': 'Merchant Name',
      'description': 'Test Payment',
      'prefill': {'contact': '9876543210', 'email': 'test@example.com'},
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());

      // Handle payment error
    }
  }
  bool isprocessing=false;
  bool isChecked = false;
  String color = "";
  String? _file; // Variable to store the selected file
  TextEditingController n1 = new TextEditingController();
  TextEditingController n2 = new TextEditingController();
  int _pageNumber = 1;
  bool _isLoading = false;
  bool _isLoad = false;
  late PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber, // Background color for the outer container
        child: Center(
          child: Container(
            width: 400, // Width of the inner container
            height: 650, // Height of the inner container
            color: Colors.white, // Background color for the inner container
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                      if (result != null) {
                        setState(() {
                          _file = result.files.single.path;
                        });
                      }
                      // Pick a file
                    },
                    backgroundColor: Colors.amber,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Preview
                  _file != null
                      ? Expanded(
                    child: _isLoading
                        ? Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    )
                        :PDFView(
                      filePath: _file!,
                      onViewCreated: (PDFViewController
                      pdfViewController) {
                        setState(() {
                          _pdfViewController = pdfViewController;
                        });
                      },
                    ),
                  )
                      : SizedBox(),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_file != null) {
                        // If file is selected, upload it using ApiService
                        try {
                          setState(() {
                            _isLoading = true;
                          });
                          print("////////////////////Filepath: $_file");
                          SharedPreferences preferences = await SharedPreferences.getInstance();
                          String userId = preferences.getString("userid") ?? "";
                          SharedPreferences preference = await SharedPreferences.getInstance();
                          String noofpages=preference.getString("noofpages") ?? "";
                          String noofbind=preference.getString("noofbind") ?? "";
                          String type=preference.getString("type") ?? "";
                          String color=preference.getString("color") ?? "";
                          String amount=preference.getString("amount") ?? "";

                          print("shareduser:$userId");
                          print("shareduser:$noofpages");
                          print("shareduser:$noofbind");
                          print("shareduser:$type");
                          print("shareduser:$color");
                          print("shareduser:$amount");

                          var response = await BindService().uploadFile(
                              userId,
                              noofpages,
                              type,
                              noofbind,
                              color,
                              _file!,
                              true// Pass the file path
                          );
                          print('Upload response: $response');
                          initiatePayment(amount);
                          final response1 = await transactionApi().pay(userId, "bind", amount);
                        } catch (e) {
                          print('Error uploading file: $e');
                          // Handle error
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                      setState((){
                        isprocessing =true;
                      }
                      );
                      await Future.delayed(Duration(seconds: 20));

                      setState(() {
                        isprocessing=false;
                      });

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                    },
                    child: Text(
                      'Upload',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding:
                      EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
