
import 'package:flutter/material.dart';
import 'package:handy/src/pages/topup.dart';
import 'package:handy/src/pages/wallet.dart';
import 'package:handy/src/pages/wallet_transaction_history.dart';

import 'src/pages/RegisterForm/register_form_step1.dart';
import 'src/pages/RegisterForm/register_form_step2.dart';
import 'src/pages/RegisterForm/register_form_step3.dart';
import 'src/pages/RegisterForm/register_form_step4.dart';
import 'src/pages/account_blocked.dart';
import 'src/pages/booking_track.dart';
import 'src/pages/calender.dart';
import 'src/pages/item_list.dart';
import 'src/pages/loginPage.dart';
import 'src/pages/forget_password.dart';
import 'src/pages/languages.dart';
import 'src/pages/notifications.dart';
import 'src/pages/pages.dart';
import 'src/pages/register.dart';
import 'src/pages/settings.dart';
import 'src/pages/splash_screen.dart';
import 'src/pages/success.dart';
import 'src/pages/take_photo.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => RegisterFormStep1());
      case '/step2':
        return MaterialPageRoute(builder: (_) => RegisterFormStep2(registerData: args,));
      case '/step3':
        return MaterialPageRoute(builder: (_) => RegisterFormStep3(registerData: args,));
      case '/step4':
        return MaterialPageRoute(builder: (_) => RegisterFormStep4(registerData: args,));
      case '/TransactionHistory':
        return MaterialPageRoute(builder: (_) => WalletTransactionHistory());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/wallet':
        return MaterialPageRoute(builder: (_) => WalletPage());
      case '/withdraw':
        return MaterialPageRoute(builder: (_) => TopUpPage());
      case '/ForgetPassword':
        return MaterialPageRoute(builder: (_) => ForgetPasswordWidget());
      case '/Pages':
        return MaterialPageRoute(builder: (_) => PagesTestWidget(currentTab: args));
      case '/viewItemDetails':
        return MaterialPageRoute(
            builder: (_) => ItemList(
                  paymentData: args,
                ));

      case '/Notifications':
        return MaterialPageRoute(builder: (_) => NotificationsWidget());
      case '/Register':
        return MaterialPageRoute(builder: (_) => Register());
      case '/Success':
        return MaterialPageRoute(builder: (_) => Success());
      case '/Languages':
        return MaterialPageRoute(builder: (_) => LanguagesWidget());
      case '/Settings':
        return MaterialPageRoute(builder: (_) => SettingsWidget());
    case '/BookTracking':
        return MaterialPageRoute(builder: (_) => BookingTrack());
      case '/my_schedule':
        return MaterialPageRoute(builder: (_) => Calendar());
      case '/takePhoto':
        return MaterialPageRoute(builder: (_) => TakePhoto());
      case '/Account_block':
        return MaterialPageRoute(builder: (_) => AccountBlock());

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(builder: (_) => Scaffold(body: SizedBox(height: 0)));
    }
  }
}
