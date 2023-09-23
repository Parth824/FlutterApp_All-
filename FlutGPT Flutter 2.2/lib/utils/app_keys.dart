import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// CHAT GPT ID
String openAiToken = "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";

/// GOOGLE ADS ID (ANDROID)
String bannerAndroidID = "ca-app-pub-9934733188869512/9156251703";
String appOpenAndroidId =  "ca-app-pub-9934733188869512/9647206298";
String interstitialAndroidId = "ca-app-pub-9934733188869512/9814727256";
String rewardedAndroidId = "ca-app-pub-9934733188869512/5707961286";

/// GOOGLE ADS ID (IOS)
String bannerIOSID = "ca-app-pub-3940256099942544/2934735716";
String appOpenIosId =  "ca-app-pub-3940256099942544/3419835294";
String interstitialIosId = "ca-app-pub-3940256099942544/4411468910";
String rewardedIosId = "ca-app-pub-9934733188869512/5707961286";

/// GOOGLE ADS SHOW/DISABLE
bool showAds = true;

/// SHOW IMAGE
bool showImage = true;

/// show dark mode
bool showDarkMode = true;

/// voice is off
bool voiceIsOff = false;

// /// PREMIUM SHOW/DISABLE
// bool isPremium = false;

/// Max Token Limit is 4096
int token = 500;

///  DARK MODE SHOW (TRUE/FALSE)
bool isDarkMode = true;
bool isLightMode = true;

/// MESSAGE LIMIT
int maxMessageLimit = 10;

/// SHOW GENERATE IMAGE
bool showImageGeneration = true;


/// ONBOARDING SCREEN 1 TEXT
String Onboarding_Title1 = '''Your AI Assistance''';
String Onboarding_Description1 = '''Using This App, You can Ask Your questions and recieve articles using artificial assistance''';

/// ONBOARDING SCREEN 2 TEXT
String Onboarding_Title2 = '''Your AI Assistance''';
String Onboarding_Description2= '''Using This App, You can Ask Your questions and recieve articles using artificial assistance''';


/// ONBOARDING SCREEN 3 TEXT
String Onboarding_Title3 = '''Your AI Assistance''';
String Onboarding_Description3 = '''Using This App, You can Ask Your questions and recieve articles using artificial assistance''';


/// IMAGE GENERTATE LIMIT
int imageGenerateLimit = 3;

/// IN APP PURCHASE ID(ANDROID)
const String monthPlanAndroid = 'android.test.purchased'; /// ENTER YOUR ONE MONTH PLAN ID
const String weekPlanAndroid = 'android.test.purchased'; /// ENTER YOUR ONE WEEK  PLAN ID
const String yearPlanAndroid = 'android.test.purchased'; /// ENTER YOUR ONE YEAR PLAN ID

/// IN APP PURCHASE ID(IOS)
const String monthPlanIOS = 'storeKeySubscription'; /// ENTER YOUR ONE MONTH PLAN ID
const String weekPlanIOS = 'storeKeySubscription'; /// ENTER YOUR ONE  WEEK PLAN ID
const String yearPlanIOS = 'storeKeySubscription'; /// ENTER YOUR ONE YEAR PLAN ID

///  TERMS PRIVACY LINK
const String termsLink = 'https://termify.io/terms-and-conditions/LZzJbfnuKl';
const String privacyLink = 'https://termify.io/privacy-policy/L1JtnFA7fv';

/// SHARE APP LINK FOR ANDROID
const String shareAppLinkAndroid = "SHARE APP LINK ANDROID";

/// SHARE APP LINK FOR  IOS
const String shareAppLinkIOSid = "SHARE APP LINK IOS";


/// IN APP PURCHASE PRICES :-
double perMonthPrice = 30; /// PER MONTH
double perWeekPrice = 10; /// PER WEEK
double perYearPrice = 149; /// PER YEAR



/// CURRENCY NAME
const String inAppCurrency = "\$";

Widget appBarTitle(BuildContext context){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children:  [
      Text("Jerry",style: TextStyle(color: context.textTheme.headline1!.color,fontSize: 30,fontWeight: FontWeight.w700),),
      const Text("",style: TextStyle(color: Color(0xff62A193),fontSize: 35,fontWeight: FontWeight.w700),),
    ],
  );
}
