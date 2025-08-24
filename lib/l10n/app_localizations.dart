import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'hello'**
  String get hello;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @oneStopShopDescription.
  ///
  /// In en, this message translates to:
  /// **'We are your one-stop online shop for everything you need. Fast delivery , great prices, and trusted brands all in one place.'**
  String get oneStopShopDescription;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'create'**
  String get create;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @usernameOrEmail.
  ///
  /// In en, this message translates to:
  /// **'Username or Email'**
  String get usernameOrEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPwd.
  ///
  /// In en, this message translates to:
  /// **'Forgot\nPassword?'**
  String get forgotPwd;

  /// No description provided for @continueWith.
  ///
  /// In en, this message translates to:
  /// **'- OR Continue with -'**
  String get continueWith;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create An Account'**
  String get createAnAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'create an account'**
  String get createAccount;

  /// No description provided for @anAccount.
  ///
  /// In en, this message translates to:
  /// **'an account'**
  String get anAccount;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @createSimple.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createSimple;

  /// No description provided for @createAnAccountLogin.
  ///
  /// In en, this message translates to:
  /// **'create an account'**
  String get createAnAccountLogin;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @passworConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get passworConfirmation;

  /// No description provided for @becomeASeller.
  ///
  /// In en, this message translates to:
  /// **'Do you wanna become a Seller / Vendor ?'**
  String get becomeASeller;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @byClickingThe.
  ///
  /// In en, this message translates to:
  /// **'By clicking the'**
  String get byClickingThe;

  /// No description provided for @publicOffer.
  ///
  /// In en, this message translates to:
  /// **'button,you agree to the public offer'**
  String get publicOffer;

  /// No description provided for @newsletter.
  ///
  /// In en, this message translates to:
  /// **'Sign up for newsletter'**
  String get newsletter;

  /// No description provided for @enableremoteshoppinghelp.
  ///
  /// In en, this message translates to:
  /// **'Enable remote shopping help'**
  String get enableremoteshoppinghelp;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'I Already Have an Account '**
  String get alreadyHaveAnAccount;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterEmail;

  /// No description provided for @resetPwd.
  ///
  /// In en, this message translates to:
  /// **'* We will send you a message to set or reset your new password'**
  String get resetPwd;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification\ncode'**
  String get verificationCode;

  /// No description provided for @sentTheVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'We have sent the verification code to'**
  String get sentTheVerificationCode;

  /// No description provided for @noCode.
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive the code ?'**
  String get noCode;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @favourites.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favourites;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @performances.
  ///
  /// In en, this message translates to:
  /// **'Performances'**
  String get performances;

  /// No description provided for @legalAndPolicies.
  ///
  /// In en, this message translates to:
  /// **'Legal And Policies'**
  String get legalAndPolicies;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @trailLanguage.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get trailLanguage;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get personalInfo;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @shippingAddress.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shippingAddress;

  /// No description provided for @streetAddress.
  ///
  /// In en, this message translates to:
  /// **'Street Address'**
  String get streetAddress;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @zipPostalCode.
  ///
  /// In en, this message translates to:
  /// **'ZIP / Postal Code'**
  String get zipPostalCode;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @invalidCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid Code'**
  String get invalidCode;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// No description provided for @payPal.
  ///
  /// In en, this message translates to:
  /// **'PayPal'**
  String get payPal;

  /// No description provided for @applePay.
  ///
  /// In en, this message translates to:
  /// **'Apple Pay'**
  String get applePay;

  /// No description provided for @cardholderName.
  ///
  /// In en, this message translates to:
  /// **'Cardholder Name'**
  String get cardholderName;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumber;

  /// No description provided for @expiry.
  ///
  /// In en, this message translates to:
  /// **'Expiry (MM/YY)'**
  String get expiry;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password Changed Successfully'**
  String get passwordChangedSuccessfully;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @oldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPassword;

  /// No description provided for @enteryourcurrentpassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Current Password'**
  String get enteryourcurrentpassword;

  /// No description provided for @reenternewpassword.
  ///
  /// In en, this message translates to:
  /// **'Re-enter New Password'**
  String get reenternewpassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @changeNow.
  ///
  /// In en, this message translates to:
  /// **'Change Now'**
  String get changeNow;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @enternewpassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get enternewpassword;

  /// No description provided for @purchaseCompleted.
  ///
  /// In en, this message translates to:
  /// **'Purchase Completed'**
  String get purchaseCompleted;

  /// No description provided for @orderPacked.
  ///
  /// In en, this message translates to:
  /// **'Order Packed'**
  String get orderPacked;

  /// No description provided for @minago.
  ///
  /// In en, this message translates to:
  /// **'min ago'**
  String get minago;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @discountApplied.
  ///
  /// In en, this message translates to:
  /// **'Discount Applied'**
  String get discountApplied;

  /// No description provided for @newFeatureUpdate.
  ///
  /// In en, this message translates to:
  /// **'New Feature Update'**
  String get newFeatureUpdate;

  /// No description provided for @searchFavorites.
  ///
  /// In en, this message translates to:
  /// **'Search favorites'**
  String get searchFavorites;

  /// No description provided for @productDescription.
  ///
  /// In en, this message translates to:
  /// **'Sample description for the product goes here.'**
  String get productDescription;

  /// No description provided for @currentPrice.
  ///
  /// In en, this message translates to:
  /// **'AED 499'**
  String get currentPrice;

  /// No description provided for @originalPrice.
  ///
  /// In en, this message translates to:
  /// **'AED 999'**
  String get originalPrice;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'50% Off'**
  String get discount;

  /// No description provided for @product0Name.
  ///
  /// In en, this message translates to:
  /// **'Nike Running Shoes'**
  String get product0Name;

  /// No description provided for @product1Name.
  ///
  /// In en, this message translates to:
  /// **'Adidas Sports Sneakers'**
  String get product1Name;

  /// No description provided for @product2Name.
  ///
  /// In en, this message translates to:
  /// **'Puma Casual Shoes'**
  String get product2Name;

  /// No description provided for @product3Name.
  ///
  /// In en, this message translates to:
  /// **'Reebok Gym Trainers'**
  String get product3Name;

  /// No description provided for @product4Name.
  ///
  /// In en, this message translates to:
  /// **'New Balance Walkers'**
  String get product4Name;

  /// No description provided for @product5Name.
  ///
  /// In en, this message translates to:
  /// **'ASICS Marathon Shoes'**
  String get product5Name;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @humanFriendly.
  ///
  /// In en, this message translates to:
  /// **'Introduction and overview'**
  String get humanFriendly;

  /// No description provided for @legalMumboJumbo.
  ///
  /// In en, this message translates to:
  /// **'Details of our policy'**
  String get legalMumboJumbo;

  /// No description provided for @privacyDescription.
  ///
  /// In en, this message translates to:
  /// **'Our human-friendly Terms of Service for the platform prevails over the detailed one, which specifies all rights and obligations in more complex legalese.\n\nIn case of contradiction between the two documents, the human-friendly Terms shall prevail. That means no nasty surprises if you read only the human-friendly version.'**
  String get privacyDescription;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated'**
  String get lastUpdated;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @searchTopics.
  ///
  /// In en, this message translates to:
  /// **'Search for topics...'**
  String get searchTopics;

  /// No description provided for @helpTopic0.
  ///
  /// In en, this message translates to:
  /// **'How to create a profile on kolshy website?'**
  String get helpTopic0;

  /// No description provided for @helpTopic1.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods ?'**
  String get helpTopic1;

  /// No description provided for @helpTopic2.
  ///
  /// In en, this message translates to:
  /// **'Track the order from the seller ?'**
  String get helpTopic2;

  /// No description provided for @helpTopic3.
  ///
  /// In en, this message translates to:
  /// **'Tracking For Customer?'**
  String get helpTopic3;

  /// No description provided for @helpTopic4.
  ///
  /// In en, this message translates to:
  /// **'What is your return policy?'**
  String get helpTopic4;

  /// No description provided for @helpTopicContent.
  ///
  /// In en, this message translates to:
  /// **' '**
  String get helpTopicContent;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @sendHint.
  ///
  /// In en, this message translates to:
  /// **'Send a message here...'**
  String get sendHint;

  /// No description provided for @presetFasterDelivery.
  ///
  /// In en, this message translates to:
  /// **'Faster Delivery time'**
  String get presetFasterDelivery;

  /// No description provided for @presetProductIssue.
  ///
  /// In en, this message translates to:
  /// **'Trouble with a product'**
  String get presetProductIssue;

  /// No description provided for @presetOther.
  ///
  /// In en, this message translates to:
  /// **'Something else...'**
  String get presetOther;

  /// No description provided for @thankYouTitle.
  ///
  /// In en, this message translates to:
  /// **'Thank you for\nshopping with us!'**
  String get thankYouTitle;

  /// No description provided for @thankYouSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your order number 16 is confirmed\nand in processing'**
  String get thankYouSubtitle;

  /// No description provided for @thankYouDescription.
  ///
  /// In en, this message translates to:
  /// **'Porem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.'**
  String get thankYouDescription;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order Number'**
  String get orderNumber;

  /// No description provided for @orderDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get orderDate;

  /// No description provided for @orderStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get orderStatus;

  /// No description provided for @statusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get statusConfirmed;

  /// No description provided for @customerInfo.
  ///
  /// In en, this message translates to:
  /// **'Customer Info'**
  String get customerInfo;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @sneakers.
  ///
  /// In en, this message translates to:
  /// **'Sneakers'**
  String get sneakers;

  /// No description provided for @orderTotal.
  ///
  /// In en, this message translates to:
  /// **'Order Total'**
  String get orderTotal;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @shipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get shipping;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @checkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkoutTitle;

  /// No description provided for @editDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit Details'**
  String get editDetails;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get placeOrder;

  /// No description provided for @myCart.
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get myCart;

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cartEmpty;

  /// No description provided for @addCoupon.
  ///
  /// In en, this message translates to:
  /// **'Add coupon code'**
  String get addCoupon;

  /// No description provided for @couponApplied.
  ///
  /// In en, this message translates to:
  /// **'Coupon applied: 10% off!'**
  String get couponApplied;

  /// No description provided for @invalidCoupon.
  ///
  /// In en, this message translates to:
  /// **'Invalid coupon code'**
  String get invalidCoupon;

  /// No description provided for @earnPointsFreeShipping.
  ///
  /// In en, this message translates to:
  /// **'You’ll earn 34 points · Free shipping'**
  String get earnPointsFreeShipping;

  /// No description provided for @proceedToCheckout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get proceedToCheckout;

  /// No description provided for @productTitle.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum'**
  String get productTitle;

  /// No description provided for @productBrand.
  ///
  /// In en, this message translates to:
  /// **'By Day Dissolve'**
  String get productBrand;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @descriptionContent.
  ///
  /// In en, this message translates to:
  /// **'Corem ipsum dolor sit amet, consectetur adipiscing elit...'**
  String get descriptionContent;

  /// No description provided for @ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredients;

  /// No description provided for @ingredientsContent.
  ///
  /// In en, this message translates to:
  /// **'Water, Glycerin, Aloe Vera...'**
  String get ingredientsContent;

  /// No description provided for @howToUse.
  ///
  /// In en, this message translates to:
  /// **'How to use'**
  String get howToUse;

  /// No description provided for @howToUseContent.
  ///
  /// In en, this message translates to:
  /// **'Apply a small amount...'**
  String get howToUseContent;

  /// No description provided for @inStock.
  ///
  /// In en, this message translates to:
  /// **'In Stock'**
  String get inStock;

  /// No description provided for @freeDelivery.
  ///
  /// In en, this message translates to:
  /// **'Free delivery'**
  String get freeDelivery;

  /// No description provided for @availableInStore.
  ///
  /// In en, this message translates to:
  /// **'Available in the nearest store'**
  String get availableInStore;

  /// No description provided for @customerReviews.
  ///
  /// In en, this message translates to:
  /// **'Customer Reviews'**
  String get customerReviews;

  /// No description provided for @recommendedProducts.
  ///
  /// In en, this message translates to:
  /// **'Products you may also like'**
  String get recommendedProducts;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add To Cart'**
  String get addToCart;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @electronics.
  ///
  /// In en, this message translates to:
  /// **'Electronics'**
  String get electronics;

  /// No description provided for @computerSoftware.
  ///
  /// In en, this message translates to:
  /// **'Computer & Software'**
  String get computerSoftware;

  /// No description provided for @fashion.
  ///
  /// In en, this message translates to:
  /// **'Fashion'**
  String get fashion;

  /// No description provided for @homeKitchen.
  ///
  /// In en, this message translates to:
  /// **'Home & Kitchen'**
  String get homeKitchen;

  /// No description provided for @healthBeauty.
  ///
  /// In en, this message translates to:
  /// **'Health & Beauty'**
  String get healthBeauty;

  /// No description provided for @groceriesFood.
  ///
  /// In en, this message translates to:
  /// **'Groceries & Food'**
  String get groceriesFood;

  /// No description provided for @childrenToys.
  ///
  /// In en, this message translates to:
  /// **'Children & Toys'**
  String get childrenToys;

  /// No description provided for @carsAccessories.
  ///
  /// In en, this message translates to:
  /// **'Cars & Accessories'**
  String get carsAccessories;

  /// No description provided for @books.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get books;

  /// No description provided for @sportsFitness.
  ///
  /// In en, this message translates to:
  /// **'Sports & Fitness'**
  String get sportsFitness;

  /// No description provided for @hiUser.
  ///
  /// In en, this message translates to:
  /// **'Hi {user}'**
  String hiUser(Object user);

  /// No description provided for @promo.
  ///
  /// In en, this message translates to:
  /// **'Promo'**
  String get promo;

  /// No description provided for @exploreProducts.
  ///
  /// In en, this message translates to:
  /// **'Explore thousands of products'**
  String get exploreProducts;

  /// No description provided for @fastDelivery.
  ///
  /// In en, this message translates to:
  /// **'Fast delivery across the Middle East'**
  String get fastDelivery;

  /// No description provided for @summerSale.
  ///
  /// In en, this message translates to:
  /// **'Summer sale 50% OFF'**
  String get summerSale;

  /// No description provided for @selectedItems.
  ///
  /// In en, this message translates to:
  /// **'On selected items, limited time!'**
  String get selectedItems;

  /// No description provided for @newArrivalsBanner.
  ///
  /// In en, this message translates to:
  /// **'New arrivals are here!'**
  String get newArrivalsBanner;

  /// No description provided for @freshestStyles.
  ///
  /// In en, this message translates to:
  /// **'Check the freshest styles now'**
  String get freshestStyles;

  /// No description provided for @bestSeller.
  ///
  /// In en, this message translates to:
  /// **'Best Seller'**
  String get bestSeller;

  /// No description provided for @shopByCategory.
  ///
  /// In en, this message translates to:
  /// **'Shop by Category'**
  String get shopByCategory;

  /// No description provided for @newArrivals.
  ///
  /// In en, this message translates to:
  /// **'New Arrivals'**
  String get newArrivals;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Forem ipsum'**
  String get productName;

  /// No description provided for @discountBanner.
  ///
  /// In en, this message translates to:
  /// **'50–40% OFF'**
  String get discountBanner;

  /// No description provided for @shopNowText.
  ///
  /// In en, this message translates to:
  /// **'On selected products\nShop now with big discounts!'**
  String get shopNowText;

  /// No description provided for @shopNow.
  ///
  /// In en, this message translates to:
  /// **'Shop Now'**
  String get shopNow;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @howtocontactus.
  ///
  /// In en, this message translates to:
  /// **'How to contact us ?'**
  String get howtocontactus;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @buyNow.
  ///
  /// In en, this message translates to:
  /// **'Buy Now'**
  String get buyNow;

  /// No description provided for @humanFriendlyPolicyText.
  ///
  /// In en, this message translates to:
  /// **'Introduction\nWe at Kolshy E-Commerce Solutions, a platform fully owned by Kolshy E-Commerce LLC, officially registered in the United Arab Emirates under license number 1401296 and solely owned by Mr. Ahmed Mohamed El-Farmawy, operate with our headquarters located at Office No. 43, Building 44, Dubai – UAE.\nWe place great importance on respecting your privacy and strive to protect all personal data collected when you use our website\nwww.kolshy.ae\nor the associated mobile application.\nFor any inquiries, you can contact us via:\n• Email: info@kolshy.ae\n• Phone / WhatsApp: +971551228825\n• Privacy Policy\nThis policy (\"Privacy Policy\") explains the basis on which we collect and use your personal data, whether collected directly from you or from other sources, in the context of accessing the platform or using any of the services we provide, including but not limited to: promotional messages, and integrated social media features (collectively referred to as \"services\").\nWe fully understand the importance of protecting your personal data and are committed to respecting and safeguarding your privacy.\nPlease read this policy carefully to understand how we handle your personal data.\nBy using the platform or services, you acknowledge and agree to the collection and use of your personal data as described in this policy.\nFor the purposes of this policy, \"personal data\" refers to all types of data mentioned in Clause (2) of this document.\nTerms such as \"user,\" \"you,\" or similar refer to the natural or legal person using the platform or services, as applicable.\nOur platform may contain links to third-party websites, plugins, or applications provided by third parties.\nWhen you click on any of these links or activate such plugins, third parties may be able to collect or share information about you.\nPlease note that we have no control over, and are not responsible for, the privacy policies or practices of such external sites.\nWhen you leave our platform, we strongly recommend that you review the privacy policy of each website you visit to ensure you fully understand how they handle your data.'**
  String get humanFriendlyPolicyText;

  /// No description provided for @legalMumboJumboPolicyText.
  ///
  /// In en, this message translates to:
  /// **'• 1. No collection of children\'s data\nThis platform is intended for adults only, in accordance with applicable laws defining the age of majority.\nThe platform is not in any way targeted at individuals under the legal age.\nHowever, we cannot always prevent some users, including minors, from providing false information about their age to access the platform.\nIf you are a parent or legal guardian and believe that we have inadvertently collected personal information about your child, please contact us immediately using the contact methods specified in Clause 12 of this Privacy Policy.\n\n• 2. What personal data do we collect from or about you?\nWe collect your personal data to continuously provide and improve our services and platform.\n\"Personal data\" means any information that can be used to identify you as an individual through direct or indirect identifiers.\nPersonal data does not include information that has been anonymized (where all identifiers have been removed).\nWe collect, store, use, and transfer various types of personal data, which can be classified as follows:\n1. Identity data: first name, middle name, last name, username or similar identifiers, gender, title, nationality, and date of birth.\n2. Contact data: residential address, email address, and phone number.\n3. Transaction data: details of payments received or made, payment methods used, and data about products or services purchased from us.\n4. Technical data: IP address, login information, browser type and version, operating system, mobile app version, time zone settings, location data, device type, advertising identifiers (e.g., in iOS), and other internet usage information. This may be collected using cookies, sessions, web beacons, and other tracking tools.\n5. Profile data: username, password, your interests and preferences, comments, preferred language, and responses to surveys.\n6. Purchase data: all previous orders, account purchases, refund information, fulfillment details, and browsing records of products and services.\n7. Interaction data: related to how you interact with our website, products, and services.\n8. Marketing and communication data: preferences for receiving promotional offers or marketing messages from us or third parties, and your preferred communication method.\nAdditionally, we may collect, use, and share statistical or demographic data known as \"aggregated data.\" These are derived from your personal data but do not reveal your identity after removing all identifiers.\nExample: we may use aggregated browsing data to analyze the percentage of users engaging with a specific feature on the platform.\n\n3. How do we collect your personal data?\nWe collect your personal data through three main methods:\n1. Directly from you:\nWe collect your data directly when you:\n- Register on the platform or log in via social media or any other registration method.\n- Make payments, request refunds, or select your preferred payment method.\n- Participate in competitions, promotions, or special programs.\n- Provide comments, reviews, or testimonials.\n- Submit support requests or complaints related to services.\n- Communicate with us via phone, email, or other channels (where correspondence is recorded).\n- Browse or engage in any activity within the platform.\n2. Indirectly:\nWe may obtain your personal data from third parties or related parties, such as:\n- Friends or relatives making purchases for you or on your behalf.\n- Partner vendors or service providers, such as logistics and fulfillment partners, marketing providers, and payment processors.\n- Interactions via platforms like Facebook, Google, etc.\nIf you share personal data about others (e.g., friends or family), you confirm you have their consent to share it under this Privacy Policy.\n3. Automatically:\nWe collect some data automatically while you use the platform, using technologies such as:\n- Log files: including IP address, browser type, pages visited, operating system, timestamps, and other technical details.\n- Cookies & sessions: small files stored on your device to improve your experience by enabling platform features, remembering your preferences, understanding your interactions, showing personalized ads, and analyzing traffic.\nIf you do not agree to the use of cookies, you may disable them in your browser settings or stop using the platform. However, disabling some data types may affect your full experience of our services.\n\n4. Why do we collect your personal data?\nWe collect and use your personal data to enhance your experience with us, including:\n1. Providing information and services.\n2. Location-based services.\n3. Fulfilling contractual obligations.\n4. Improving services and communication.\n5. Optimizing content display.\n6. Offering personalized services for special occasions.\n7. Notifying you about updates.\n8. Improving your overall experience.\n9. Managing reward programs.\n10. Improving technical performance.\n11. Complying with local laws.\n12. Preventing fraud and ensuring security.\n\n5. How do we use your personal data?\nWe use your personal data only when necessary, including:\n1. Contract execution.\n2. Legal compliance.\n3. Legitimate interests.\n4. Marketing and communication (with opt-out options).\n\n6. Who do we share your personal data with?\n1. Affiliates and service providers.\n2. Third parties for specific purposes.\n3. In case of merger or transfer of ownership.\n4. Legal compliance and protection of rights.\n\n7. How do we store your personal data and for how long?\nWe store your data only for as long as necessary for the purposes stated or as required by law. Factors considered include data sensitivity, risk level, purpose achievement, and legal requirements.\nWe may anonymize data for indefinite research or statistical use.\n\n8. What security measures do we apply?\nWe use commercially reasonable technical, administrative, and physical safeguards, such as encryption, firewalls, restricted access, and PCI DSS compliance.\nYou are also responsible for protecting your account information.\n\n9. Your rights regarding your personal data:\n1. Right to information.\n2. Right to access.\n3. Right to request deletion.\n4. Right to withdraw consent or object.\n5. Right to correct data.\n6. No fee for exercising rights (unless legally required).\n\n10. How do we update our Privacy Policy?\nWe may update it to reflect changes in our operations. Updates will be posted on the platform and become effective upon posting (or a stated effective date).\n\n11. Contact us:\nFor any inquiries:\n• WhatsApp: +971551228825\n• Email: info@kolshy.ae\nPlease include details in your message for faster assistance.'**
  String get legalMumboJumboPolicyText;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfileTitle;

  /// No description provided for @stepPersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get stepPersonalInfo;

  /// No description provided for @stepShippingAddress.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get stepShippingAddress;

  /// No description provided for @stepPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get stepPaymentMethod;

  /// No description provided for @personalInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get personalInfoTitle;

  /// No description provided for @shippingAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shippingAddressTitle;

  /// No description provided for @paymentMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethodTitle;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @expiryMmYy.
  ///
  /// In en, this message translates to:
  /// **'Expiry (MM/YY)'**
  String get expiryMmYy;

  /// No description provided for @cvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// No description provided for @paymentMethodCard.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get paymentMethodCard;

  /// No description provided for @paymentMethodPayPal.
  ///
  /// In en, this message translates to:
  /// **'PayPal'**
  String get paymentMethodPayPal;

  /// No description provided for @paymentMethodApplePay.
  ///
  /// In en, this message translates to:
  /// **'Apple Pay'**
  String get paymentMethodApplePay;

  /// No description provided for @paymentMethodTabby.
  ///
  /// In en, this message translates to:
  /// **'Tabby '**
  String get paymentMethodTabby;

  /// No description provided for @paymentMethodTamara.
  ///
  /// In en, this message translates to:
  /// **'Tamara '**
  String get paymentMethodTamara;

  /// No description provided for @payNowCard.
  ///
  /// In en, this message translates to:
  /// **'Pay now (Card)'**
  String get payNowCard;

  /// No description provided for @continueWithPayPal.
  ///
  /// In en, this message translates to:
  /// **'Continue with PayPal'**
  String get continueWithPayPal;

  /// No description provided for @payWithApplePay.
  ///
  /// In en, this message translates to:
  /// **'Pay with Apple Pay'**
  String get payWithApplePay;

  /// No description provided for @continueWithTabby.
  ///
  /// In en, this message translates to:
  /// **'Continue with Tabby'**
  String get continueWithTabby;

  /// No description provided for @continueWithTamara.
  ///
  /// In en, this message translates to:
  /// **'Continue with Tamara'**
  String get continueWithTamara;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @invalidZipCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid code'**
  String get invalidZipCode;

  /// No description provided for @invalidCardNumber16Digits.
  ///
  /// In en, this message translates to:
  /// **'16 digits needed'**
  String get invalidCardNumber16Digits;

  /// No description provided for @invalidExpiryMmYy.
  ///
  /// In en, this message translates to:
  /// **'Use MM/YY format'**
  String get invalidExpiryMmYy;

  /// No description provided for @invalidCvv.
  ///
  /// In en, this message translates to:
  /// **'Invalid CVV'**
  String get invalidCvv;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @pleaseCompleteRequiredInformation.
  ///
  /// In en, this message translates to:
  /// **'Please complete the required information.'**
  String get pleaseCompleteRequiredInformation;

  /// No description provided for @pleaseCompleteCardDetails.
  ///
  /// In en, this message translates to:
  /// **'Please complete your card details.'**
  String get pleaseCompleteCardDetails;

  /// No description provided for @paymentDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'{method} payment'**
  String paymentDialogTitle(Object method);

  /// No description provided for @paymentSuccessfulSnack.
  ///
  /// In en, this message translates to:
  /// **'{method}: payment successful'**
  String paymentSuccessfulSnack(Object method);

  /// No description provided for @paymentSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'{method} payment successful.'**
  String paymentSuccessMessage(Object method);

  /// No description provided for @paymentFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'{method} payment failed.'**
  String paymentFailedMessage(Object method);

  /// No description provided for @paymentError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String paymentError(Object error);

  /// No description provided for @missingPayPalApproveUrl.
  ///
  /// In en, this message translates to:
  /// **'Missing PayPal approve URL'**
  String get missingPayPalApproveUrl;

  /// No description provided for @missingTabbyCheckoutUrl.
  ///
  /// In en, this message translates to:
  /// **'Missing Tabby checkoutUrl'**
  String get missingTabbyCheckoutUrl;

  /// No description provided for @missingTamaraRedirectUrl.
  ///
  /// In en, this message translates to:
  /// **'Missing Tamara redirectUrl'**
  String get missingTamaraRedirectUrl;

  /// No description provided for @couldNotOpen.
  ///
  /// In en, this message translates to:
  /// **'Could not open {what}'**
  String couldNotOpen(Object what);

  /// No description provided for @deleteAccountConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountConfirmTitle;

  /// No description provided for @deleteAccountConfirmContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get deleteAccountConfirmContent;

  /// No description provided for @accountDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully!'**
  String get accountDeletedSuccessfully;

  /// Section title above vendor bio on the vendor profile page
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get vendorAboutTitle;

  /// Section title above the vendor products grid
  ///
  /// In en, this message translates to:
  /// **'Our Products'**
  String get vendorProductsTitle;

  /// Button label at the bottom of the vendor profile page
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get vendorEditProfile;

  /// Vendor bio paragraph shown under 'About Us'
  ///
  /// In en, this message translates to:
  /// **'We are a leading provider of high-quality electronics and adventure gear. Our mission is to bring you the best products to enhance your daily life and outdoor experiences.'**
  String get vendorBio;

  /// Vendor location text displayed under the company name
  ///
  /// In en, this message translates to:
  /// **'New York, USA'**
  String get vendorLocation;

  /// Localized name for the 'electronics' category
  ///
  /// In en, this message translates to:
  /// **'Electronics'**
  String get categoryElectronics;

  /// Localized name for the 'accessories' category
  ///
  /// In en, this message translates to:
  /// **'Accessories'**
  String get categoryAccessories;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
