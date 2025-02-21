import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tsavaari/common/widgets/text/t_section_heading.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_history_shimmer.dart';
import 'package:tsavaari/features/reward_points/controllers/reward_points_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class LoyaltyPointsHistory extends StatelessWidget {
  const LoyaltyPointsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final RewardPointsController controller = RewardPointsController.instance;
    return Column(
      children: [
        const TSectionHeading(
          title: 'History',
          showActionBtn: false,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        Obx(() {
          if (controller.isLoadingPointsHistory.value) {
            return const CardHiistroyShimmer();
          }
          
          if (controller.loyaltyPointsHistory.isNotEmpty) {
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final history = controller.loyaltyPointsHistory[index];

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: TColors.grey),
                    borderRadius:
                        BorderRadius.circular(TSizes.borderRadiusMd),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(TSizes.md),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                history.transactionCategory?.contains('RECHARGE') == true
                                ? 'Card Recharge'
                                : 'QR Ticket '
                            ),
                    
                            Text(
                              _formatDate(history.date ?? ''),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: TSizes.xs,
                        ),
                    
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              history.qrorderidOrCardNumber ?? '',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                    
                            Text(
                              history.type == 'earning'
                                  ? '+ ${history.points}'
                                  : '- ${history.points}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: history.type == 'earning' 
                                        ? TColors.success 
                                        : TColors.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: TSizes.xs,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Prev. Points : ',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                Text(
                                  history.previousRewardPointsBalance ?? '',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ],
                            ),
                    
                            Row(
                              children: [
                                Text(
                                  'Curr. Points : ',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                Text(
                                  history.currentRewardPointsBalance.toString(),
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ],
                            ),
                          ],
                        )
                              
                      ], 
                    ),
                  ),
                );
              },
              separatorBuilder: (contex, index) {
                return const SizedBox(
                  height: TSizes.spaceBtwItems,
                );
              },
              itemCount: controller.loyaltyPointsHistory.length
            );
          }

          return const Center(
            child: Text('No History'),
          );

        }),
      ],
    );
  }

  String _formatDate(String dateString) {
    if (dateString.isEmpty) return 'No date available';
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }
}