// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'dart:io' show Platform;
//
// void main() {
//   if (Platform.isAndroid) {
//     // Execute Android-specific code
//     print('Running on Android');
//   } else if (Platform.isIOS) {
//     // Execute iOS-specific code
//     print('Running on iOS');
//   } if (kIsWeb) {
//     // Handle web-specific code
//     print('Web platform detected');
//   }
//   else {
//     // Handle unsupported platforms
//     print('Unsupported platform');
//   }
// }
//
//
// class PaymentGatewayPage extends StatefulWidget {
//   @override
//   _PaymentGatewayPageState createState() => _PaymentGatewayPageState();
// }
//
// class _PaymentGatewayPageState extends State<PaymentGatewayPage> {
//   Razorpay? _razorpay;
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     print('Payment Success: ${response.paymentId}');
//     print("success");
//     // Handle payment success
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     print('Payment Error: ${response.message}');
//     print("success");
//     // Handle payment error
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     print('External Wallet: ${response.walletName}');
//     print("success");
//     // Handle external wallet
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _razorpay=Razorpay();
//     _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet );
//   }
//
//   void initiatePayment() async {
//     print("payemnt");
//     var options = {
//       'key': 'rzp_test_TtSDhSH3AFn8Su',
//       'amount': 10000, // Payment amount in paisa (e.g., 10000 for ₹100)
//       'name': 'Merchant Name',
//       'description': 'Test Payment',
//       'prefill': {'contact': '9876543210', 'email': 'test@example.com'},
//     };
//     try {
//       _razorpay?.open(options);
//     } catch (e) {
//       debugPrint(e.toString());
//
//       // Handle payment error
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Payment Gateway'),
//         ),
//         body: Center(
//             child: ElevatedButton(
//               onPressed: initiatePayment,
//               child: Text('Pay Now'),
//             ),
//             ),
//         );
//     }
// }