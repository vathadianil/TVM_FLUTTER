import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/bottom_sheet_pageview_controller.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/bottom_sheet_main_page.dart';
// import 'package:tsavaari/features/qr/display_qr/screens/widgets/change_destination_preview.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/refund_preview.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/ticket_status_codes.dart';
// import 'package:tsavaari/utils/device/device_utility.dart';

class DisplayQrBottomSheet extends StatelessWidget {
  const DisplayQrBottomSheet({
    super.key,
    this.tickets,
    required this.stationList,
    required this.orderId,
  });

  final List<TicketsListModel>? tickets;
  final List<StationListModel>? stationList;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    List<TicketsListModel> filterTicketsByCode(String entryExitCode) {
      return tickets!
          .where((ticket) => ticket.entryExitCode == entryExitCode)
          .toList();
    }

    List<TicketsListModel>? getRjtTicketData() {
      if (tickets == null || tickets!.isEmpty) {
        return null;
      }

      final rjtInwardTickets = filterTicketsByCode('RJT_OUTWARD');
      final rjtReturnTickets = filterTicketsByCode('RJT RETURN');

      bool isInwardJourneyCompleted = rjtInwardTickets.any(
        (ticket) => ticket.ticketStatus == TicketStatusCodes.newTicketString,
      );
      return isInwardJourneyCompleted ? rjtInwardTickets : rjtReturnTickets;
    }

    final bottomSheetController = Get.put(BottomSheetPageViewController());

    return Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: PageView(
          controller: bottomSheetController.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const BottomSheetMainPage(),
            // ChangeDesinationPreview(
            //   tickets: tickets![0].ticketType ==
            //           TicketStatusCodes.ticketTypeRjtString
            //       ? getRjtTicketData()
            //       : tickets,
            //   stationList: stationList,
            // ),
            RefundPreview(
              tickets: tickets![0].ticketType ==
                      TicketStatusCodes.ticketTypeRjtString
                  ? getRjtTicketData()
                  : tickets,
              orderId: orderId,
            ),
          ],
        ));
  }
}
