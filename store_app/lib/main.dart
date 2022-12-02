import 'dart:io';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:login_and_signup_web/src/elements/HeaderDashboard.dart';
import 'package:login_and_signup_web/src/pages/Orders.dart';
import 'package:login_and_signup_web/src/pages/Orders_takeaway.dart';
import 'package:login_and_signup_web/src/pages/add_item.dart';
import 'package:login_and_signup_web/src/pages/add_product.dart';
import 'package:login_and_signup_web/src/pages/barcodepdf.dart';
import 'package:login_and_signup_web/src/pages/bulkupload.dart';
import 'package:login_and_signup_web/src/pages/category.dart';
import 'package:login_and_signup_web/src/pages/dashboard.dart';
import 'package:login_and_signup_web/src/pages/delivery_timeslot.dart';
import 'package:login_and_signup_web/src/pages/pos_checkout.dart';
import 'package:login_and_signup_web/src/pages/product_list.dart';
import 'package:login_and_signup_web/src/pages/profile.dart';
import 'package:login_and_signup_web/src/pages/report.dart';
import 'package:login_and_signup_web/src/pages/rtypeproduct_list.dart';
import 'package:login_and_signup_web/src/pages/slip.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/pages/subcategory.dart';
import 'package:login_and_signup_web/src/pages/walletwidget.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'generated/l10n.dart';
import 'src/models/setting.dart';
import 'src/pages/Orders_list.dart';
import 'src/pages/Orders_list_takeaway.dart';
import 'src/repository/settings_repository.dart' as settingRepo;
import 'src/repository/user_repository.dart' as userRepo;
import 'package:flutter/material.dart';


import 'package:login_and_signup_web/src/elements/InvoiceWidget.dart';


import 'package:login_and_signup_web/src/pages/banners.dart';

import 'package:login_and_signup_web/src/pages/home.dart';
import 'package:login_and_signup_web/src/pages/languages.dart';

import 'package:login_and_signup_web/src/pages/vendor_list.dart';
import 'package:vrouter/vrouter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(!GetPlatform.isDesktop){
    Firebase.initializeApp();
  }


  await GlobalConfiguration().loadFromAsset("configurations");
  //print(CustomTrace(StackTrace.current, message: "base_url: ${GlobalConfiguration().getString('base_url')}"));
  //print(CustomTrace(StackTrace.current, message: "api_base_url: ${GlobalConfiguration().getString('api_base_url')}"));
  //HttpOverrides.global = new MyHttpOverrides();

  settingRepo.initSettings();
  userRepo.getCurrentUser();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  void initState() {



  }

  Future<void> authenticationCheck(BuildContext context, { VRedirector vRedirector}) async {




      if (userRepo.currentUser.value.auth!=true)
      {
        // ignore: deprecated_member_use
        vRedirector.push('/login', queryParameters: {'redirectedFrom': '${vRedirector.to}'});
      }



  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: settingRepo.setting,

        builder: (context, Setting _setting, _) {
          return VRouter(
            title: setting.value.appName,
            locale: _setting.mobileLanguage.value,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: _setting.brightness.value == Brightness.light
                ?ThemeData(
              fontFamily: 'proximanova-regular',
              primaryColor: Colors.white,
              disabledColor: Colors.grey,
              cardColor: Colors.white,
              secondaryHeaderColor: Color(0xFF043832).withOpacity(1.0),
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF180968)),
              primaryColorLight: Colors.white,
              backgroundColor: Colors.black,
              dividerColor: Color(0xFF8c98a8).withOpacity(0.1),
              focusColor: Color(0xFF8c98a8).withOpacity(1.0),
              primaryColorDark: Color(0xFF180968),

              textTheme: TextTheme(
                headline5: TextStyle(fontSize: 22.0, color: Color(0xFF043832).withOpacity(1.0), height: 1.3),
                headline4: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: Color(0xFF043832).withOpacity(1.0), height: 1.3),
                headline3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, color: Color(0xFF043832).withOpacity(1.0), height: 1.3),
                headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: Color(0xFF180968).withOpacity(1.0), height: 1.4),
                headline1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: Color(0xFF043832).withOpacity(1.0), height: 1.4),
                subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: Colors.black, height: 1.3),
                subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: Color(0xFF043832).withOpacity(1.0), height: 1.2),
                headline6: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700, color: Color(0xFF180968).withOpacity(1.0), height: 1.3),
                bodyText2: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.black, height: 1.2),
                bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xFF043832).withOpacity(1.0), height: 1.3),
                caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color: Color(0xFF8c98a8).withOpacity(1.0), height: 1.7),
              ),
            ): ThemeData(
              fontFamily: 'proximanova-regular',
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Color(0xFF2C2C2C),
              primaryColorLight: Colors.white,
              primaryColor: Color(0xFF2C2C2C),
              backgroundColor: Color(0xFF9999aa),
              colorScheme: Theme.of(context).colorScheme.copyWith(
                background: const Color(0xFF000000),
                onBackground: const Color(0xFF2e2e2e),
                primary: const Color(0xFF6553D9),
                onPrimary: const Color(0xFFeeeeee),
                brightness: Brightness.dark,
                  secondary: Color(0xFF180968)
              ),
              dividerColor: Color(0xFF9999aa).withOpacity(0.1),
              hintColor: Color(0xFFccccdd).withOpacity(0.1),
              focusColor: Color(0xFF9999aa).withOpacity(1),
              primaryColorDark: Color(0xFF180968),
              textTheme: TextTheme(
                headline5: TextStyle(fontSize: 22.0, color: Color(0xFF9999aa).withOpacity(1), height: 1.3),
                headline4: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: Color(0xFF9999aa).withOpacity(1), height: 1.3),
                headline3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, color: Color(0xFF9999aa).withOpacity(1), height: 1.3),
                headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: Color(0xFF180968).withOpacity(1.0), height: 1.4),
                headline1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: Color(0xFFffffff).withOpacity(1), height: 1.4),
                subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: Color(0xFF9999aa).withOpacity(1), height: 1.3),
                subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: Color(0xFF9999aa).withOpacity(1), height: 1.2),
                headline6: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700, color: Color(0xFF180968).withOpacity(1.0), height: 1.3),
                bodyText2: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Color(0xFF9999aa).withOpacity(1), height: 1.2),
                bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xFF9999aa).withOpacity(1), height: 1.3),
                caption: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: Color(0xFF9999aa).withOpacity(0.6), height: 1.2),
              ),
            ),
            debugShowCheckedModeBanner: false,
            routes: [
              VWidget(path: '/login', widget: HomePage()),
              VGuard(
                beforeEnter: (vRedirector) =>
                    authenticationCheck(context, vRedirector: vRedirector),
                stackedRoutes: [
                  VPopHandler(
                    onPop: (_) async => print('POP'),
                    stackedRoutes: [

                      VNester(
                        path: null,
                        name: 'VNester1',
                        widgetBuilder: (child) => MyScaffold(
                          child,
                          title: 'VNester1',
                        ),
                        nestedRoutes: [
                          VWidget(
                            path: '/Order',
                            name: 'Orders',
                            widget: Orders(),
                            aliases: ['/Orders'],
                          ),
                          VWidget(
                            path: '/takeaway',
                            name: 'Orders',
                            widget: OrdersTakeaway(),
                            aliases: ['/Orders'],
                          ),
                          VWidget(
                            path: '/pos_checkout',
                            name: 'pos_checkout',
                            widget: PosCheckout(),
                            aliases: ['/pos_checkout'],
                          ),
                          VWidget(
                            path: '/Order',
                            name: 'Orders',
                            widget: Orders(),
                            aliases: ['/Orders'],
                          ),
                          VWidget(
                            path: '/wallet',
                            name: 'wallet',
                            widget: WalletWidget(),
                            aliases: ['/wallet'],
                          ),

                          VWidget(
                            path: '/productlist',
                            name: 'productlist',
                            widget: ProductList(),
                            aliases: ['/productlist'],
                          ),
                          VWidget(
                            path: '/itemlist',
                            name: 'itemlist',
                            widget: RTypeProductList(),
                            aliases: ['/itemlist'],
                          ),
                          VWidget(
                            path: '/add_product',
                            name: 'add_product',
                            widget: AddProduct(),
                            aliases: ['/add_product'],
                          ),
                          VWidget(
                            path: '/add_item',
                            name: 'add_item',
                            widget: AddItem(),
                            aliases: ['/add_item'],
                          ),
                          VWidget(
                            path: '/deliverytimeslot',
                            name: 'deliverytimrslot',
                            widget: DeliveryTimeSlot(),
                            aliases: ['/add_product'],
                          ),
                          VWidget(
                            path: '/vendorlist',
                            name: 'vendorlist',
                            widget: VendorList(),
                            aliases: ['/vendorlist'],
                          ),
                          VWidget(
                            path: '/profile',
                            name: 'profile',
                            widget: ProfileView(),
                            aliases: ['/profiledata'],
                          ),
                          VWidget(
                            path: '/subcategory',
                            name: 'subcategory',
                            widget: SubCategoryPage(),
                            aliases: ['/subcategory'],
                          ),
                          VWidget(
                            path: '/dashboard',
                            name: 'dashboard',
                            widget: DashboardWidget(),
                            aliases: ['/dashboard'],
                          ),
                          VWidget(
                            path: '/banner',
                            name: 'banner',
                            widget: Banners(),
                            aliases: ['/banner'],
                          ),
                          VWidget(
                            path: '/invoice/:id',
                            name: 'invoice',
                            widget: InvoiceWidget(),
                            aliases: ['/invoice'],
                          ),
                          VWidget(
                            path: '/Order_new',
                            name: 'Order_new',
                            widget: OrdersList(pageType: 'Placed',),
                            aliases: ['/Orders'],
                          ),
                          VWidget(
                            path: '/Order_placed',
                            name: 'Order_placed',
                            widget: OrdersList(pageType: 'Accepted',),
                            aliases: ['/Orders'],
                          ),
                          VWidget(
                            path: '/Order_packed',
                            name: 'Order_packed',
                            widget: OrdersList(pageType: 'Packed',),
                            aliases: ['/Orders'],
                          ),
                          VWidget(
                            path: '/Order_shipped',
                            name: 'Order_shipped',
                            widget: OrdersList(pageType: 'Shipped',),
                            aliases: ['/Orders'],
                          ),

                          VWidget(
                            path: '/Order_delivered',
                            name: 'Order_delivered',
                            widget: OrdersList(pageType: 'Delivered',),
                            aliases: ['/Orders'],
                          ),
                          VWidget(
                            path: '/Order_cancelled',
                            name: 'Order_cancelled',
                            widget: OrdersList(pageType: 'Cancelled',),
                            aliases: ['/Orders'],
                          ),


                          VWidget(
                            path: '/TOrder_new',
                            name: 'TOrder_new',
                            widget: OrdersListTakeaway(pageType: 'Placed',),
                            aliases: ['/TOrders'],
                          ),
                          VWidget(
                            path: '/TOrder_placed',
                            name: 'TOrder_placed',
                            widget: OrdersListTakeaway(pageType: 'Accepted',),
                            aliases: ['/TOrders'],
                          ),
                          VWidget(
                            path: '/TOrder_packed',
                            name: 'TOrder_packed',
                            widget: OrdersListTakeaway(pageType: 'Packed',),
                            aliases: ['/TOrders'],
                          ),


                          VWidget(
                            path: '/TOrder_delivered',
                            name: 'TOrder_delivered',
                            widget: OrdersListTakeaway(pageType: 'Delivered',),
                            aliases: ['/TOrders'],
                          ),
                          VWidget(
                            path: '/TOrder_cancelled',
                            name: 'TOrder_cancelled',
                            widget: OrdersListTakeaway(pageType: 'Cancelled',),
                            aliases: ['/TOrders'],
                          ),


                          VWidget(
                            path: '/category',
                            widget: CategoryPage(),

                            // Custom transition
                          ),
                          VWidget(
                            path: '/bulk_upload',
                            widget: BulkUpload(),

                            // Custom transition
                          ),
                          VWidget(
                            path: '/report',
                            widget: Report(),

                            // Custom transition
                          ),
                          VWidget(
                            path: '/language',
                            widget: LanguagesWidget(),
                            // Custom transition
                          ),
                          VWidget(
                            path: '/Barcode',
                            widget: BarCodePdf(),

                            // Custom transition
                          ),
                          VWidget(
                            path: '/Wallet',
                            widget: WalletWidget(),

                            // Custom transition
                          ),
                          VWidget(
                            path: '/Pos_Checkout',
                            widget: PosCheckout(),

                            // Custom transition
                          ),


                          VWidget(
                            path: '/thermalSlip',
                            widget: Slip(),

                            // Custom transition
                          ),                        ],
                      ),
                    ],
                  ),
                ],
              ),
              VRouteRedirector(
                redirectTo: '/login',
                path: r':_(.*)',
              ),

            ],);});
  }
}

