import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/shapes/circle_shape.dart';
import 'package:tsavaari/common/widgets/shapes/dashed_vertical_line.dart';
import 'package:tsavaari/features/card_reacharge/models/card_travel_history_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class TravelHistoryCard extends StatelessWidget {
  const TravelHistoryCard({
    super.key,
    required this.cardTravelData,
  });

  final CardTravelHistoryList cardTravelData;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        TSizes.sm,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.md),
        color: isDark ? TColors.dark : TColors.light,
        border: Border.all(
          width: 1,
          color: isDark ? TColors.darkerGrey : TColors.grey,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            THelperFunctions.getFormattedDateString2(
              cardTravelData.travelDateTime ?? '',
            ),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: TSizes.sm,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Deducted Amt. ',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        '\u{20B9}${cardTravelData.dDCTAmount}/-',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontSize: 22),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.sm,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.md, vertical: TSizes.sm),
                    decoration: BoxDecoration(
                      color: isDark ? TColors.darkContainer : TColors.white,
                      borderRadius: BorderRadius.circular(TSizes.lg),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Balance',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(
                          width: TSizes.sm,
                        ),
                        Text(
                          '${cardTravelData.reminingBalance}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleShape(
                            borderWidth: 2,
                            width: 12,
                            height: 12,
                          ),
                          const SizedBox(
                            width: TSizes.sm,
                          ),
                          SizedBox(
                            width: 80,
                            child: Text(
                              cardTravelData.fromStation ?? '',
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections + 3,
                      ),
                      Row(
                        children: [
                          const CircleShape(
                            borderWidth: 2,
                            width: 12,
                            height: 12,
                            fillColor: TColors.dark,
                          ),
                          const SizedBox(
                            width: TSizes.sm,
                          ),
                          SizedBox(
                            width: 80,
                            child: Text(
                              cardTravelData.toStation ?? '',
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Positioned(
                    top: 15,
                    left: 6,
                    child: CustomPaint(
                      size: Size(3, 38),
                      painter:
                          DashedLineVerticalPainter(color: TColors.darkGrey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
