import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectWidgets {
  static Widget listEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            color: Colors.white,
          );
        },
      ),
    );
  }
}
