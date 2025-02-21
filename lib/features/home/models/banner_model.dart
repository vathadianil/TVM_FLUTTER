class BannerModel {
  final Data? data;

  BannerModel({
    this.data,
  });

  factory BannerModel.fromJson(Map<String, dynamic>? json) {
    return BannerModel(
      data: json == null ? null : Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class Data {
  final String? message;
  final bool? success;
  final List<Banner>? banners;
  final AdsSettings? adsSettings;
  final List<dynamic>? errors;

  Data({
    this.message,
    this.success,
    this.banners,
    this.adsSettings,
    this.errors,
  });

  factory Data.fromJson(Map<String, dynamic>? json) {
    return Data(
      message: json?['message'],
      success: json?['success'],
      banners: json?['banners'] == null
          ? null
          : List<Banner>.from(
              (json!['banners'] as List).map((x) => Banner.fromJson(x))),
      adsSettings: json?['ads_settings'] != null
          ? AdsSettings.fromJson(json!['ads_settings'] as Map<String, dynamic>)
          : null,
      errors: json?['errors'] == null
          ? null
          : List<dynamic>.from(json!['errors']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      'banners': banners?.map((x) => x.toJson()).toList(),
      'ads_settings': adsSettings?.toJson(),
      'errors': errors,
    };
  }
}

class Banner {
  final int? id;
  final int? userid;
  final String? bannerName;
  final String? bannerType;
  final String? startDate;
  final String? endDate;
  final String? createdDate;
  final List<String>? youtubeLinks;
  final List<BannerDetail>? bannerDetails;
  final String? status;
  final dynamic deletedByUser;
  final dynamic deletedAt;
  final dynamic updatedUser;
  final dynamic updatedAt;

  Banner({
    this.id,
    this.userid,
    this.bannerName,
    this.bannerType,
    this.startDate,
    this.endDate,
    this.createdDate,
    this.youtubeLinks,
    this.bannerDetails,
    this.status,
    this.deletedByUser,
    this.deletedAt,
    this.updatedUser,
    this.updatedAt,
  });

  factory Banner.fromJson(Map<String, dynamic>? json) {
    return Banner(
      id: json?['id'],
      userid: json?['userid'],
      bannerName: json?['banner_name'],
      bannerType: json?['banner_type'],
      startDate: json?['start_date'],
      endDate: json?['end_date'],
      createdDate: json?['created_date'],
      youtubeLinks: json?['youtube_links'] == null
          ? null
          : List<String>.from(json!['youtube_links']),
      bannerDetails: json?['banner_details'] == null
          ? null
          : List<BannerDetail>.from(
              (json!['banner_details'] as List)
                  .map((x) => BannerDetail.fromJson(x))),
      status: json?['status'],
      deletedByUser: json?['deleted_by_user'],
      deletedAt: json?['deleted_at'],
      updatedUser: json?['updated_user'],
      updatedAt: json?['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userid': userid,
      'banner_name': bannerName,
      'banner_type': bannerType,
      'start_date': startDate,
      'end_date': endDate,
      'created_date': createdDate,
      'youtube_links': youtubeLinks,
      'banner_details': bannerDetails?.map((x) => x.toJson()).toList(),
      'status': status,
      'deleted_by_user': deletedByUser,
      'deleted_at': deletedAt,
      'updated_user': updatedUser,
      'updated_at': updatedAt,
    };
  }
}

class BannerDetail {
  final String? imageUrl;
  final String? imageName;
  final int? bannerSortId;
  final String? bannerMetaTitle;
  final String? bannerRedirectLink;

  BannerDetail({
    this.imageUrl,
    this.imageName,
    this.bannerSortId,
    this.bannerMetaTitle,
    this.bannerRedirectLink,
  });

  factory BannerDetail.fromJson(Map<String, dynamic>? json) {
    return BannerDetail(
      imageUrl: json?['image_url'],
      imageName: json?['image_name'],
      bannerSortId: json?['banner_sort_id'],
      bannerMetaTitle: json?['banner_meta_title'],
      bannerRedirectLink: json?['banner_redirect_link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_url': imageUrl,
      'image_name': imageName,
      'banner_sort_id': bannerSortId,
      'banner_meta_title': bannerMetaTitle,
      'banner_redirect_link': bannerRedirectLink,
    };
  }
}

class AdsSettings {
  final bool? showGoogleAdsLoginPage;
  final bool? showBannersLoginPage;
  final bool? noAdsLoginPage;
  final bool? showGoogleAdsHomePage;
  final bool? showBannersHomePage;
  final bool? noAdsHomePage;
  final bool? showGoogleAdsRechargeBanner;
  final bool? showBannersRechargeBanner;
  final bool? noAdsRechargeBanner;
  final bool? showGoogleAdsQRTicketBooking;
  final bool? showBannersQRTicketBooking;
  final bool? noAdsQRTicketBooking;
  final bool? showGoogleAdsQRTicketDetails;
  final bool? showBannersQRTicketDetails;
  final bool? noAdsQRTicketDetails;
  final bool? showGoogleAdsMetroNetworkMap;
  final bool? showBannersMetroNetworkMap;
  final bool? noAdsMetroNetworkMap;

  AdsSettings({
    this.showGoogleAdsLoginPage,
    this.showBannersLoginPage,
    this.noAdsLoginPage,
    this.showGoogleAdsHomePage,
    this.showBannersHomePage,
    this.noAdsHomePage,
    this.showGoogleAdsRechargeBanner,
    this.showBannersRechargeBanner,
    this.noAdsRechargeBanner,
    this.showGoogleAdsQRTicketBooking,
    this.showBannersQRTicketBooking,
    this.noAdsQRTicketBooking,
    this.showGoogleAdsQRTicketDetails,
    this.showBannersQRTicketDetails,
    this.noAdsQRTicketDetails,
    this.showGoogleAdsMetroNetworkMap,
    this.showBannersMetroNetworkMap,
    this.noAdsMetroNetworkMap,
  });

  factory AdsSettings.fromJson(Map<String, dynamic> json) {
    return AdsSettings(
      showGoogleAdsLoginPage: json['Login_page']['show_google_ads'],
      showBannersLoginPage: json['Login_page']['show_banners'],
      noAdsLoginPage: json['Login_page']['no_ads'],
      showGoogleAdsHomePage: json['Home_page']['show_google_ads'],
      showBannersHomePage: json['Home_page']['show_banners'],
      noAdsHomePage: json['Home_page']['no_ads'],
      showGoogleAdsRechargeBanner: json['Recharge_banner']['show_google_ads'],
      showBannersRechargeBanner: json['Recharge_banner']['show_banners'],
      noAdsRechargeBanner: json['Recharge_banner']['no_ads'],
      showGoogleAdsQRTicketBooking: json['QR_Ticket_booking']['show_google_ads'],
      showBannersQRTicketBooking: json['QR_Ticket_booking']['show_banners'],
      noAdsQRTicketBooking: json['QR_Ticket_booking']['no_ads'],
      showGoogleAdsQRTicketDetails: json['QR_Ticket_details']['show_google_ads'],
      showBannersQRTicketDetails: json['QR_Ticket_details']['show_banners'],
      noAdsQRTicketDetails: json['QR_Ticket_details']['no_ads'],
      showGoogleAdsMetroNetworkMap: json['Metro_network_map']['show_google_ads'],
      showBannersMetroNetworkMap: json['Metro_network_map']['show_banners'],
      noAdsMetroNetworkMap: json['Metro_network_map']['no_ads'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Login_page': {
        'show_google_ads': showGoogleAdsLoginPage,
        'show_banners': showBannersLoginPage,
        'no_ads': noAdsLoginPage,
      },
      'Home_page': {
        'show_google_ads': showGoogleAdsHomePage,
        'show_banners': showBannersHomePage,
        'no_ads': noAdsHomePage,
      },
      'Recharge_banner': {
        'show_google_ads': showGoogleAdsRechargeBanner,
        'show_banners': showBannersRechargeBanner,
        'no_ads': noAdsRechargeBanner,
      },
      'QR_Ticket_booking': {
        'show_google_ads': showGoogleAdsQRTicketBooking,
        'show_banners': showBannersQRTicketBooking,
        'no_ads': noAdsQRTicketBooking,
      },
      'QR_Ticket_details': {
        'show_google_ads': showGoogleAdsQRTicketDetails,
        'show_banners': showBannersQRTicketDetails,
        'no_ads': noAdsQRTicketDetails,
      },
      'Metro_network_map': {
        'show_google_ads': showGoogleAdsMetroNetworkMap,
        'show_banners': showBannersMetroNetworkMap,
        'no_ads': noAdsMetroNetworkMap,
      },
    };
  }
}
