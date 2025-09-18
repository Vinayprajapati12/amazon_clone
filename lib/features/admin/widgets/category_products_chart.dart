import 'package:amazon_clone/features/admin/models/sales.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> salesData;
  const CategoryProductsChart({Key? key, required this.salesData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barGroups = salesData.asMap().entries.map((entry) {
      int index = entry.key;
      Sales sale = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: sale.earning.toDouble(),
            color: Colors.blue,
            borderRadius: BorderRadius.circular(6),
            width: 22,
          ),
        ],
      );
    }).toList();

    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          barGroups: barGroups,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                getTitlesWidget: (value, meta) {
                  final formatted = NumberFormat.compact().format(
                    value.toInt(),
                  );
                  return Text(
                    formatted,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() < 0 || value.toInt() >= salesData.length) {
                    return Container();
                  }
                  return Transform.rotate(
                    angle: -0.7,
                    child: Text(
                      salesData[value.toInt()].label,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: true),
          alignment: BarChartAlignment.spaceAround,
        ),
      ),
    );
  }
}
