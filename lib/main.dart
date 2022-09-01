import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isw_mobile_sdk/isw_mobile_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  @override
  void initState() {
    initSdk();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: TextButton(
        child: Text("Open payment"),
        onPressed: () {},
      )),
    );
  }

  Future<void> pay(int amount) async {
    var customerId = "<customer-id>",
        customerName = "<customer-name>",
        customerEmail = "<customer.email@domain.com>",
        customerMobile = "<customer-phone>",
        // generate a unique random
        // reference for each transaction
        reference = "<your-unique-ref>";

    // initialize amount
    // amount expressed in lowest
    // denomination (e.g. kobo): "N500.00" -> 50000
    int amountInKobo = amount * 100;

    // create payment info
    var iswPaymentInfo = new IswPaymentInfo(customerId, customerName,
        customerEmail, customerMobile, reference, amountInKobo);

    // trigger payment
    var result = await IswMobileSdk.pay(iswPaymentInfo);

    // process result
    handleResult(result);
  }

  // messages to SDK are asynchronous, so we initialize in an async method.
  Future<void> initSdk() async {
    // messages may fail, so we use a try/catch PlatformException.
    try {
      String merchantId = "your-merchant-id",
          merchantCode = "your-merchant-code",
          merchantSecret = "your-merchant-secret",
          currencyCode = "currency-code"; // e.g  566 for NGN

      var config = new IswSdkConfig(
          merchantId, merchantSecret, merchantCode, currencyCode);

      // initialize the sdk
      await IswMobileSdk.initialize(config);
      // intialize with environment, default is Environment.TEST
      // IswMobileSdk.initialize(config, Environment.SANDBOX);

    } on PlatformException {}
  }

  void handleResult(Optional<IswPaymentResult> result) {
    if (result.hasValue) {
      // process result
    } else {}
  }
}
