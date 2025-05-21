import 'package:flutter/material.dart';

class HourlyBarChartItem {
  final String time;
  final double value;
  final Color color;
  final String? topLabel;
  final String? bottomLabel;
  final Widget? icon;
  final Widget? topIcon;

  HourlyBarChartItem({
    required this.time,
    required this.value,
    required this.color,
    this.topLabel,
    this.bottomLabel,
    this.icon,
    this.topIcon,
  });
}

class HourlyBarChart extends StatelessWidget {
  final List<HourlyBarChartItem> items;
  final double height;
  final double barWidth;
  final double spacing;

  const HourlyBarChart({
    super.key,
    required this.items,
    this.height = 0.18,
    this.barWidth = 25,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(width: spacing),
        itemBuilder: (context, index) {
          final item = items[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (item.topIcon != null) item.topIcon!,
              if (item.topIcon != null) const Spacer(),
              Container(
                height: item.value,
                width: barWidth,
                decoration: BoxDecoration(
                  color: item.color,
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              const SizedBox(height: 5),
              if (item.topLabel != null) Center(child: Text(item.topLabel!)),
              const SizedBox(height: 5),
              if (item.icon != null) item.icon!,
              const SizedBox(height: 5),
              if (item.bottomLabel != null)
                Text(
                  item.bottomLabel!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
          );
        },
      ),
    );
  }
}
