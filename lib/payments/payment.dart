import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../my-globals.dart' as globals;

class PaymentPage extends StatefulWidget {
  static String id = 'payment';
  PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_EuF395pyMv8oc1",
      "amount": globals.amount * 100,
      "name": "Siren 24",
      "description": "Payment forAmbulance service",
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    print("Payment success");
  }

  void handlerErrorFailure() {
    print("Payment error");
  }

  void handlerExternalWallet() {
    print("External Wallet");
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              Expanded(child: SizedBox()),
              Image.asset('assets/mainlogo.png'),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  openCheckout();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Color(0xFF4C6EE4),
                  ),
                  height: 50,
                  width: width - 20,
                  child: Center(
                    child: Text(
                      'pay online',
                      style: TextStyle(
                          fontSize: 19,
                          fontFamily: 'Roboto',
                          wordSpacing: 2,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
             /*  GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Color(0xFF4C6EE4),
                  ),
                  height: 50,
                  width: width - 20,
                  child: Center(
                    child: Text(
                      'pay in cash',
                      style: TextStyle(
                          fontSize: 19,
                          fontFamily: 'Roboto',
                          wordSpacing: 2,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ), */
              Expanded(child: SizedBox()),
            ],
          ),
        ));
  }
}
