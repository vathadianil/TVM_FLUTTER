import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/containers/t_ticket_shape_widget.dart';
import 'package:tsavaari/features/home/screens/widgets/banner_image_slider.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/qr_ticket_content_container.dart';
import 'package:tsavaari/utils/constants/banner_page_type.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class QrTicketCard extends StatelessWidget {
  const QrTicketCard({
    super.key,
    required this.tickets,
    required this.stationList, 
    required this.ltmrhlPurchaseId,
  });
  final List<TicketsListModel> tickets;
  final List<StationListModel> stationList;
  final String ltmrhlPurchaseId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TTicketShapeWidget(
          child: Column(
            children: [
              QrTicketContentContainer(
                tickets: tickets,
                stationList: stationList,
                ltmrhlPurchaseId: ltmrhlPurchaseId, 
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              //-- Display Google Ads Or Banners
              BannerImageSlider(
                autoPlay: true,
                pageType: BannerPageType.qrTicketsDetails
              ),
            ],
          ),
        ),
      ],
    );
  }
}
