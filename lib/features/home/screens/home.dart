import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/layout/t_grid_layout.dart';
import 'package:tsavaari/common/widgets/text/t_section_heading.dart';
import 'package:tsavaari/features/home/controllers/social_media_controller.dart';
import 'package:tsavaari/features/home/models/metro_services_model.dart';
import 'package:tsavaari/features/home/screens/widgets/header_section_container.dart';
import 'package:tsavaari/features/home/screens/widgets/home_app_bar.dart';
import 'package:tsavaari/features/home/screens/widgets/banner_image_slider.dart';
import 'package:tsavaari/features/home/screens/widgets/service_cards.dart';
import 'package:tsavaari/utils/constants/banner_page_type.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late SocialMediaController _socialMediaController;

  @override
  void initState() {
    super.initState();
    _socialMediaController = SocialMediaController(this);
  }

  @override
  void dispose() {
    _socialMediaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = TDeviceUtils.getScreenHeight();
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final List<MetroServicesModel> servicesList = [
      MetroServicesModel(
        id: '1',
        active: true,
        icon: 'qrcode',
        title: 'Book\nTicket',
        targetScreen: '/book-qr',
      ),
      MetroServicesModel(
        id: '2',
        active: true,
        icon: 'card',
        title: 'Card\nRecharge',
        targetScreen: '/card-recharge',
      ),
      MetroServicesModel(
        id: '3',
        active: true,
        icon: 'fare',
        title: 'Fare\nCalculator',
        targetScreen: '/fare-calculator',
      ),
      MetroServicesModel(
        id: '4',
        active: true,
        icon: 'facilities',
        title: 'Station\nFacilities',
        targetScreen: '/station-facilities',
      ),
      MetroServicesModel(
        id: '5',
        active: true,
        icon: 'map',
        title: 'Metro\nMap',
        targetScreen: '/metro-network-map',
      ),
      MetroServicesModel(
        id: '6',
        active: true,
        icon: 'media',
        title: 'Follow\nUs',
        targetScreen: '/media',
      ),
    ];

    List<MetroServicesModel> getActiveServiceList() {
      final activeServices =
          servicesList.where((service) => service.active).toList();
      return activeServices;
    }

    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              //Appbar
              const HeaderSectionContainer(
                child: HomeAppBar(),
              ),

              //Body
              Column(
                children: [
                  //-- Display Google Ads Or Banners
                  BannerImageSlider(
                    autoPlay: true,
                    pageType: BannerPageType.homePage,
                    width: screenWidth * .6,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        //Heading
                        const TSectionHeading(
                          title: TTexts.metroServicesSectionHeading,
                          showActionBtn: false,
                          padding: EdgeInsets.only(left: 0),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        // Services Grid
                        GridLayout(
                          itemCount: getActiveServiceList().length,
                          mainAxisExtent: screenHeight * .2,
                          crossAxisCount: 6,
                          mainAxisSpacing: TSizes.gridViewSpacing,
                          crossAxisSpacing: screenWidth * .06,
                          itemBuilder: (BuildContext context, int index) {
                            final activeServiceList = getActiveServiceList();
                            return ServiceCards(
                              service: activeServiceList[index],
                              onMediaTap: _socialMediaController.handleMediaTap,
                            );
                          },
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSections * 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: (screenHeight -
                  (_socialMediaController.socialIcons.length *
                      (screenWidth * 0.14 + TSizes.xs * 2))) /
              2,
          child: ValueListenableBuilder<bool>(
            valueListenable: _socialMediaController.isExpandedNotifier,
            builder: (context, isExpanded, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: isExpanded ? screenWidth * 0.14 : 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _socialMediaController.socialIcons
                      .asMap()
                      .entries
                      .map((entry) {
                        final index = entry.key;
                        final icon = entry.value;
                        return AnimatedBuilder(
                          animation: _socialMediaController.animationController,
                          builder: (context, child) {
                            return SlideTransition(
                              position: _socialMediaController
                                  .getSlideAnimation(index),
                              child: Container(
                                width: screenWidth * 0.14,
                                height: screenWidth * 0.12,
                                decoration: BoxDecoration(
                                  color: icon['color'],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    bottomLeft: Radius.circular(25),
                                  ),
                                ),
                                margin: const EdgeInsets.symmetric(
                                    vertical: TSizes.xs),
                                child: InkWell(
                                  onTap: () => _socialMediaController
                                      .launchSocialMedia(icon['url'],
                                          mode: 'app'),
                                  child: Image.asset(
                                    icon['icon'],
                                    width: screenWidth * 0.10,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      })
                      .toList()
                      .reversed
                      .toList(),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
