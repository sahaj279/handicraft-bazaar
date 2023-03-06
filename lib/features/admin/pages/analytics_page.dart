import 'package:ecommerce_webapp/features/admin/model/Sale_Model.dart';
import 'package:ecommerce_webapp/features/admin/services/admin_services.dart';
import 'package:ecommerce_webapp/features/admin/widgets/category_wise_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  List<Sale>? sales;
  int? totalEarning;
  @override
  void initState() {
    getEarnings();
    super.initState();
  }

  getEarnings() async {
    var data = await AdminServices().getAnalyticsData(context: context);
    sales = data['sales'];
    totalEarning = data['totalPrice'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return sales == null || totalEarning == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Text(
                '\$$totalEarning',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 250,
                child: CateforyWiseChart(seriesList: [
                  charts.Series(
                      id: 'Sales',
                      data: sales!,
                      domainFn: (Sale sale, _) => sale.label,
                      measureFn: (Sale sale, _) => sale.earning)
                ]),
              )
            ],
          );
  }
}
