import 'package:ecommerce_webapp/features/admin/model/Sale_Model.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CateforyWiseChart extends StatelessWidget {
  final List<charts.Series<Sale,String>> seriesList; 
  const CateforyWiseChart({super.key, required this.seriesList});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList
      ,
      animate: true,);
  }
}