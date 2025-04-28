// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;

// class TermsOfUsePage extends StatefulWidget {
//   @override
//   _TermsOfUsePageState createState() => _TermsOfUsePageState();
// }

// class _TermsOfUsePageState extends State<TermsOfUsePage> {
//   late Future<String> _loadHtmlFromAssets;

//   @override
//   void initState() {
//     super.initState();
//     _loadHtmlFromAssets = _loadHtml();
//   }

//   Future<String> _loadHtml() async {
//     return await rootBundle.loadString('assets/web/terms_of_use.html');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Terms of Use'),
//       ),
//       body: FutureBuilder<String>(
//         future: _loadHtmlFromAssets,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error loading page'));
//           } else {
//             return WebView(
//              javascriptMode: JavascriptMode.unrestricted,
//             initialUrl: 'assets/web/terms_of_ues.html',
//             onWebViewCreated: (controllerPlus) {
//               print("[DEBUG] WEB VIEW");
//             },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
