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
  /// **'card holder name'**
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
  /// **'HUMAN-FRIENDLY'**
  String get humanFriendly;

  /// No description provided for @legalMumboJumbo.
  ///
  /// In en, this message translates to:
  /// **'LEGAL MUMBO-JUMBO'**
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
  /// **'How to create an account?'**
  String get helpTopic0;

  /// No description provided for @helpTopic1.
  ///
  /// In en, this message translates to:
  /// **'How to track my order?'**
  String get helpTopic1;

  /// No description provided for @helpTopic2.
  ///
  /// In en, this message translates to:
  /// **'How to change my password?'**
  String get helpTopic2;

  /// No description provided for @helpTopic3.
  ///
  /// In en, this message translates to:
  /// **'How to contact customer service?'**
  String get helpTopic3;

  /// No description provided for @helpTopic4.
  ///
  /// In en, this message translates to:
  /// **'What is your return policy?'**
  String get helpTopic4;

  /// No description provided for @helpTopicContent.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.'**
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

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;
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
