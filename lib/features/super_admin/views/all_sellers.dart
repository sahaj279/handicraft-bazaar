// import 'package:ecommerce_webapp/features/admin/model/Sale_Model.dart';
// import 'package:ecommerce_webapp/features/admin/services/admin_services.dart';
// import 'package:ecommerce_webapp/features/admin/widgets/category_wise_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:charts_flutter_new/flutter.dart' as charts;

// class AllSellersPage extends StatefulWidget {
//   const AllSellersPage({super.key});

//   @override
//   State<AllSellersPage> createState() => _AnalyticsPageState();
// }

// class _AnalyticsPageState extends State<AllSellersPage> {
//   @override
//   void initState() {
//     getEarnings();
//     super.initState();
//   }

//   getEarnings() async {
//     var data = await AdminServices().getAnalyticsData(context: context);
//     sales = data['sales'];
//     totalEarning = data['totalPrice'];
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return sales == null || totalEarning == null
//         ? const Center(
//             child: CircularProgressIndicator(),
//           )
//         : Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const Text(
//                   'Analytics',
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.left,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Text(
//                   'The plot shows which category of your products is the highest seller.',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black87,
//                   ),
//                   textAlign: TextAlign.left,
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   'Total earning: \u{20B9}$totalEarning',
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 SizedBox(
//                   height: 250,
//                   child: CateforyWiseChart(seriesList: [
//                     charts.Series(
//                       id: 'Sales',
//                       data: sales!,
//                       domainFn: (Sale sale, _) => sale.label,
//                       measureFn: (Sale sale, _) => sale.earning,
//                     )
//                   ]),
//                 )
//               ],
//             ),
//           );
//   }
// }
