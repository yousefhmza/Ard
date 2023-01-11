class EndPoints {
  // Splash
  static const String getCurrentUser = "/profile";

  // Auth
  static const String updateOtp = "/update-otp";
  static const String login = "/otp";
  static const String register = "/register";

  // Offer
  static const String getOffer = "/offer";
  static const String getOfferAttributes = "/offer/attributes";
  static const String getCitiesAndAreas = "/city-area";
  static const String addOffer = "/add_offer";
  static const String sendLandRequest = "/land-request";
  static const String addRealestateAppraisal = "/real-estate-appraisal";
  static const String sendReport = "/send-report";
  static const String landsList = "/land-request-list";
  static const String singleLand = "/land-single";

  static const String subscription = "/subscription";
  static const String sendBankTransferImage = "/add-subscription";

  //Profile
  static const String profile = "/profile";
  static const String updateProfile = "/update-profile";

  //Comments
  static const String comments = "/offer-rating";
  static const String offerViewCount = "/offer-count-view";
  static const String addComment = "/rating";
  static const String offersList = "/offer-list";
  static const String myOffersList = "/my-offer-list";
  static const String offerRenew = "/offer-renew";
  static const String offerDelete = "/offer-delete";
  static const String offerChangeStatus = "/offer-change-status";
}
