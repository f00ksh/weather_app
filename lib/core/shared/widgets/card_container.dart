import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_dimension.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const CardContainer({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    final surfaceContainer = Theme.of(context).colorScheme.surfaceContainer;
    return Container(
      width: double.infinity,
      margin: AppDimension.cardMargin,
      padding: padding ?? AppDimension.cardPadding,
      decoration: BoxDecoration(
        color: surfaceContainer,
        borderRadius: BorderRadius.circular(26),
      ),
      child: child,
    );
  }
}

// RoundCardContainer
class RoundCardContainer extends StatelessWidget {
  final Widget child;

  const RoundCardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final surfaceContainer = Theme.of(context).colorScheme.surfaceContainer;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: surfaceContainer,
      ),
      child: child,
    );
  }
}
