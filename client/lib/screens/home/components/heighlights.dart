import 'package:flutter/material.dart';
import 'package:area/components/animated_counter.dart';
import 'package:area/responsive.dart';

import '../../../constants.dart';
import 'heigh_light.dart';

class HighLightsInfo extends StatelessWidget {
  const HighLightsInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: Responsive.isMobileLarge(context)
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    HeighLight(
                      counter: AnimatedCounter(
                        value: 6,
                        text: "POUTINE",
                      ),
                      label: "Vladimir",
                    ),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                HeighLight(
                  counter: AnimatedCounter(
                    value: 6,
                    text: "POUTINE",
                  ),
                  label: "Vladimir",
                ),
              ],
            ),
    );
  }
}
