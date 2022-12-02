// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance;
  }

  static S maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get dark_mode {
    return Intl.message(
      'Dark mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Order id`
  String get order_id {
    return Intl.message(
      'Order id',
      name: 'order_id',
      desc: '',
      args: [],
    );
  }

  /// `Delivery boy`
  String get delivery_boy {
    return Intl.message(
      'Delivery boy',
      name: 'delivery_boy',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Recent orders`
  String get recent_orders {
    return Intl.message(
      'Recent orders',
      name: 'recent_orders',
      desc: '',
      args: [],
    );
  }

  /// `User bio`
  String get user_bio {
    return Intl.message(
      'User bio',
      name: 'user_bio',
      desc: '',
      args: [],
    );
  }

  /// `Orders history`
  String get orders_history {
    return Intl.message(
      'Orders history',
      name: 'orders_history',
      desc: '',
      args: [],
    );
  }

  /// `Address not provided contact client`
  String get address_not_provided_contact_client {
    return Intl.message(
      'Address not provided contact client',
      name: 'address_not_provided_contact_client',
      desc: '',
      args: [],
    );
  }

  /// `Cus name`
  String get cus_name {
    return Intl.message(
      'Cus name',
      name: 'cus_name',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get items {
    return Intl.message(
      'Items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Ordered products`
  String get ordered_products {
    return Intl.message(
      'Ordered products',
      name: 'ordered_products',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customer {
    return Intl.message(
      'Customer',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `Vat price`
  String get vat_price {
    return Intl.message(
      'Vat price',
      name: 'vat_price',
      desc: '',
      args: [],
    );
  }

  /// `Sub total`
  String get sub_total {
    return Intl.message(
      'Sub total',
      name: 'sub_total',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Delivery address`
  String get delivery_address {
    return Intl.message(
      'Delivery address',
      name: 'delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `alt number`
  String get alt_number {
    return Intl.message(
      'alt number',
      name: 'alt_number',
      desc: '',
      args: [],
    );
  }

  /// `Pay status`
  String get pay_status {
    return Intl.message(
      'Pay status',
      name: 'pay_status',
      desc: '',
      args: [],
    );
  }

  /// `Delivery confirmation`
  String get delivery_confirmation {
    return Intl.message(
      'Delivery confirmation',
      name: 'delivery_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Would you pleas confirm if you have delivered all meals to client`
  String get would_you_pleas_confirm_if_you_have_delivered_all_meals_to_client {
    return Intl.message(
      'Would you pleas confirm if you have delivered all meals to client',
      name: 'would_you_pleas_confirm_if_you_have_delivered_all_meals_to_client',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Dismiss`
  String get dismiss {
    return Intl.message(
      'Dismiss',
      name: 'dismiss',
      desc: '',
      args: [],
    );
  }

  /// `Cash on delivery`
  String get cash_on_delivery {
    return Intl.message(
      'Cash on delivery',
      name: 'cash_on_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Online`
  String get online {
    return Intl.message(
      'Online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `Offline`
  String get offline {
    return Intl.message(
      'Offline',
      name: 'offline',
      desc: '',
      args: [],
    );
  }

  /// `Enter your text`
  String get enter_your_text {
    return Intl.message(
      'Enter your text',
      name: 'enter_your_text',
      desc: '',
      args: [],
    );
  }

  /// `Application preferences`
  String get application_preferences {
    return Intl.message(
      'Application preferences',
      name: 'application_preferences',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get full_name {
    return Intl.message(
      'Full name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `App settings`
  String get app_settings {
    return Intl.message(
      'App settings',
      name: 'app_settings',
      desc: '',
      args: [],
    );
  }

  /// `Help & support`
  String get help_and_support {
    return Intl.message(
      'Help & support',
      name: 'help_and_support',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `App language`
  String get app_language {
    return Intl.message(
      'App language',
      name: 'app_language',
      desc: '',
      args: [],
    );
  }

  /// `Select your prefered languages`
  String get select_your_prefered_languages {
    return Intl.message(
      'Select your prefered languages',
      name: 'select_your_prefered_languages',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `if you dont have account`
  String get if_you_dont_have_account {
    return Intl.message(
      'if you dont have account',
      name: 'if_you_dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Mobile`
  String get mobile {
    return Intl.message(
      'Mobile',
      name: 'mobile',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account`
  String get already_have_an_account {
    return Intl.message(
      'Already have an account',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Swipe left the notification to delete or read / unread it`
  String get swipe_left_the_notification_to_delete_or_read_unread_it {
    return Intl.message(
      'Swipe left the notification to delete or read / unread it',
      name: 'swipe_left_the_notification_to_delete_or_read_unread_it',
      desc: '',
      args: [],
    );
  }

  /// `Item is packed successfully`
  String get item_is_packed_successfully {
    return Intl.message(
      'Item is packed successfully',
      name: 'item_is_packed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Contact info`
  String get contact_info {
    return Intl.message(
      'Contact info',
      name: 'contact_info',
      desc: '',
      args: [],
    );
  }

  /// `Pickup address`
  String get pickup_address {
    return Intl.message(
      'Pickup address',
      name: 'pickup_address',
      desc: '',
      args: [],
    );
  }

  /// `Successfully`
  String get successfully {
    return Intl.message(
      'Successfully',
      name: 'successfully',
      desc: '',
      args: [],
    );
  }

  /// `This account is not exist`
  String get this_account_is_not_exist {
    return Intl.message(
      'This account is not exist',
      name: 'this_account_is_not_exist',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get light_mode {
    return Intl.message(
      'Light Mode',
      name: 'light_mode',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Order details`
  String get order_details {
    return Intl.message(
      'Order details',
      name: 'order_details',
      desc: '',
      args: [],
    );
  }

  /// `Delivery addresses`
  String get delivery_addresses {
    return Intl.message(
      'Delivery addresses',
      name: 'delivery_addresses',
      desc: '',
      args: [],
    );
  }

  /// `Pickup`
  String get pickup {
    return Intl.message(
      'Pickup',
      name: 'pickup',
      desc: '',
      args: [],
    );
  }

  /// `Enter otp`
  String get enter_otp {
    return Intl.message(
      'Enter otp',
      name: 'enter_otp',
      desc: '',
      args: [],
    );
  }

  /// `Update successfully`
  String get update_successfully {
    return Intl.message(
      'Update successfully',
      name: 'update_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Verify your internet connection`
  String get verify_your_internet_connection {
    return Intl.message(
      'Verify your internet connection',
      name: 'verify_your_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Wrong email or password`
  String get wrong_email_or_password {
    return Intl.message(
      'Wrong email or password',
      name: 'wrong_email_or_password',
      desc: '',
      args: [],
    );
  }

  /// `Your reset link has been sent to your email`
  String get your_reset_link_has_been_sent_to_your_email {
    return Intl.message(
      'Your reset link has been sent to your email',
      name: 'your_reset_link_has_been_sent_to_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Error verify email settings`
  String get error_verify_email_settings {
    return Intl.message(
      'Error verify email settings',
      name: 'error_verify_email_settings',
      desc: '',
      args: [],
    );
  }

  /// `OTP is not matched`
  String get otp_is_not_matched {
    return Intl.message(
      'OTP is not matched',
      name: 'otp_is_not_matched',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `NO DATA FOUND`
  String get no_data_found {
    return Intl.message(
      'NO DATA FOUND',
      name: 'no_data_found',
      desc: '',
      args: [],
    );
  }

  /// `Today earn`
  String get today_earn {
    return Intl.message(
      'Today earn',
      name: 'today_earn',
      desc: '',
      args: [],
    );
  }

  /// `Total earn`
  String get total_earn {
    return Intl.message(
      'Total earn',
      name: 'total_earn',
      desc: '',
      args: [],
    );
  }

  /// `This month`
  String get this_month {
    return Intl.message(
      'This month',
      name: 'this_month',
      desc: '',
      args: [],
    );
  }

  /// `Last 7 days`
  String get last_7_days {
    return Intl.message(
      'Last 7 days',
      name: 'last_7_days',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Total orders`
  String get total_orders {
    return Intl.message(
      'Total orders',
      name: 'total_orders',
      desc: '',
      args: [],
    );
  }

  /// `Cash in your hand`
  String get cash_in_your_hand {
    return Intl.message(
      'Cash in your hand',
      name: 'cash_in_your_hand',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Ago`
  String get ago {
    return Intl.message(
      'Ago',
      name: 'ago',
      desc: '',
      args: [],
    );
  }

  /// `View details`
  String get view_details {
    return Intl.message(
      'View details',
      name: 'view_details',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Your cards`
  String get your_cards {
    return Intl.message(
      'Your cards',
      name: 'your_cards',
      desc: '',
      args: [],
    );
  }

  /// `Total balance`
  String get total_balance {
    return Intl.message(
      'Total balance',
      name: 'total_balance',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get withdraw {
    return Intl.message(
      'Withdraw',
      name: 'withdraw',
      desc: '',
      args: [],
    );
  }

  /// `Topup your wallet`
  String get top_up_your_wallet {
    return Intl.message(
      'Topup your wallet',
      name: 'top_up_your_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get transfer {
    return Intl.message(
      'Transfer',
      name: 'transfer',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get see_all {
    return Intl.message(
      'See all',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }

  /// `Recent trancations`
  String get recent_trancations {
    return Intl.message(
      'Recent trancations',
      name: 'recent_trancations',
      desc: '',
      args: [],
    );
  }

  /// `Profile settings`
  String get profile_settings {
    return Intl.message(
      'Profile settings',
      name: 'profile_settings',
      desc: '',
      args: [],
    );
  }

  /// `Forgot`
  String get forgot {
    return Intl.message(
      'Forgot',
      name: 'forgot',
      desc: '',
      args: [],
    );
  }

  /// `Processing orders`
  String get processing_orders {
    return Intl.message(
      'Processing orders',
      name: 'processing_orders',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Forgot_password`
  String get forgot_password {
    return Intl.message(
      'Forgot_password',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalid_email {
    return Intl.message(
      'Invalid email',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get first_name {
    return Intl.message(
      'First name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get last_name {
    return Intl.message(
      'Last name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Driving mode`
  String get driving_mode {
    return Intl.message(
      'Driving mode',
      name: 'driving_mode',
      desc: '',
      args: [],
    );
  }

  /// `Freelancer`
  String get freelancer {
    return Intl.message(
      'Freelancer',
      name: 'freelancer',
      desc: '',
      args: [],
    );
  }

  /// `Shop`
  String get shop {
    return Intl.message(
      'Shop',
      name: 'shop',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get others {
    return Intl.message(
      'Others',
      name: 'others',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `Zipcode`
  String get zipcode {
    return Intl.message(
      'Zipcode',
      name: 'zipcode',
      desc: '',
      args: [],
    );
  }

  /// `Get address from map`
  String get get_address_from_map {
    return Intl.message(
      'Get address from map',
      name: 'get_address_from_map',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your address`
  String get please_enter_your_address {
    return Intl.message(
      'Please enter your address',
      name: 'please_enter_your_address',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Valid mobile number`
  String get valid_mobile_number {
    return Intl.message(
      'Valid mobile number',
      name: 'valid_mobile_number',
      desc: '',
      args: [],
    );
  }

  /// `Driving licence `
  String get driving_licence {
    return Intl.message(
      'Driving licence ',
      name: 'driving_licence',
      desc: '',
      args: [],
    );
  }

  /// `Upload your`
  String get upload_your {
    return Intl.message(
      'Upload your',
      name: 'upload_your',
      desc: '',
      args: [],
    );
  }

  /// `Today orders`
  String get today_orders {
    return Intl.message(
      'Today orders',
      name: 'today_orders',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Transaction details`
  String get transaction_details {
    return Intl.message(
      'Transaction details',
      name: 'transaction_details',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Bank transfer`
  String get bank_transfer {
    return Intl.message(
      'Bank transfer',
      name: 'bank_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Your amount is debited`
  String get your_amount_is_debited {
    return Intl.message(
      'Your amount is debited',
      name: 'your_amount_is_debited',
      desc: '',
      args: [],
    );
  }

  /// `Your amount is credited`
  String get your_amount_is_credited {
    return Intl.message(
      'Your amount is credited',
      name: 'your_amount_is_credited',
      desc: '',
      args: [],
    );
  }

  /// `Transaction id`
  String get transaction_id {
    return Intl.message(
      'Transaction id',
      name: 'transaction_id',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Order deliver`
  String get order_deliver {
    return Intl.message(
      'Order deliver',
      name: 'order_deliver',
      desc: '',
      args: [],
    );
  }

  /// `Big details`
  String get big_details {
    return Intl.message(
      'Big details',
      name: 'big_details',
      desc: '',
      args: [],
    );
  }

  /// `To pay`
  String get to_pay {
    return Intl.message(
      'To pay',
      name: 'to_pay',
      desc: '',
      args: [],
    );
  }

  /// `Pickuped`
  String get pickuped {
    return Intl.message(
      'Pickuped',
      name: 'pickuped',
      desc: '',
      args: [],
    );
  }

  /// `Live track`
  String get live_track {
    return Intl.message(
      'Live track',
      name: 'live_track',
      desc: '',
      args: [],
    );
  }

  /// `On time`
  String get on_time {
    return Intl.message(
      'On time',
      name: 'on_time',
      desc: '',
      args: [],
    );
  }

  /// `My bookings`
  String get my_bookings {
    return Intl.message(
      'My bookings',
      name: 'my_bookings',
      desc: '',
      args: [],
    );
  }

  /// `Purchase`
  String get purchase {
    return Intl.message(
      'Purchase',
      name: 'purchase',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Don’t receive otp? Resend otp`
  String get dont_receive_otp_resend_otp {
    return Intl.message(
      'Don’t receive otp? Resend otp',
      name: 'dont_receive_otp_resend_otp',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Prev`
  String get prev {
    return Intl.message(
      'Prev',
      name: 'prev',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Otp verification`
  String get otp_verification {
    return Intl.message(
      'Otp verification',
      name: 'otp_verification',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Payment details`
  String get payment_details {
    return Intl.message(
      'Payment details',
      name: 'payment_details',
      desc: '',
      args: [],
    );
  }

  /// `Direction`
  String get direction {
    return Intl.message(
      'Direction',
      name: 'direction',
      desc: '',
      args: [],
    );
  }

  /// `Order pick up`
  String get order_pick_up {
    return Intl.message(
      'Order pick up',
      name: 'order_pick_up',
      desc: '',
      args: [],
    );
  }

  /// `Bill details`
  String get bill_details {
    return Intl.message(
      'Bill details',
      name: 'bill_details',
      desc: '',
      args: [],
    );
  }

  /// `Payment model`
  String get payment_model {
    return Intl.message(
      'Payment model',
      name: 'payment_model',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Food`
  String get food {
    return Intl.message(
      'Food',
      name: 'food',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Set new password`
  String get set_new_password {
    return Intl.message(
      'Set new password',
      name: 'set_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Driver id`
  String get driver_id {
    return Intl.message(
      'Driver id',
      name: 'driver_id',
      desc: '',
      args: [],
    );
  }

  /// `You have received a new shipment`
  String get you_have_received_a_new_shipment {
    return Intl.message(
      'You have received a new shipment',
      name: 'you_have_received_a_new_shipment',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get failed {
    return Intl.message(
      'Failed',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `Accepted`
  String get accepted {
    return Intl.message(
      'Accepted',
      name: 'accepted',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get processing {
    return Intl.message(
      'Processing',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Deliver id`
  String get deliver_id {
    return Intl.message(
      'Deliver id',
      name: 'deliver_id',
      desc: '',
      args: [],
    );
  }

  /// `Driver time`
  String get driver_time {
    return Intl.message(
      'Driver time',
      name: 'driver_time',
      desc: '',
      args: [],
    );
  }

  /// `Shop name`
  String get shopname {
    return Intl.message(
      'Shop name',
      name: 'shopname',
      desc: '',
      args: [],
    );
  }

  /// `Shop address`
  String get shopaddress {
    return Intl.message(
      'Shop address',
      name: 'shopaddress',
      desc: '',
      args: [],
    );
  }

  /// `New assign`
  String get new_assign {
    return Intl.message(
      'New assign',
      name: 'new_assign',
      desc: '',
      args: [],
    );
  }

  /// `Transgender`
  String get transgender {
    return Intl.message(
      'Transgender',
      name: 'transgender',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_password {
    return Intl.message(
      'Change password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `My orders`
  String get my_orders {
    return Intl.message(
      'My orders',
      name: 'my_orders',
      desc: '',
      args: [],
    );
  }

  /// `Help center`
  String get help_center {
    return Intl.message(
      'Help center',
      name: 'help_center',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Transaction`
  String get transaction {
    return Intl.message(
      'Transaction',
      name: 'transaction',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Item total`
  String get item_total {
    return Intl.message(
      'Item total',
      name: 'item_total',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Delivery tips`
  String get delivery_tips {
    return Intl.message(
      'Delivery tips',
      name: 'delivery_tips',
      desc: '',
      args: [],
    );
  }

  /// `Tax`
  String get tax {
    return Intl.message(
      'Tax',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `Go to home`
  String get go_to_home {
    return Intl.message(
      'Go to home',
      name: 'go_to_home',
      desc: '',
      args: [],
    );
  }

  /// `Credit`
  String get credit {
    return Intl.message(
      'Credit',
      name: 'credit',
      desc: '',
      args: [],
    );
  }

  /// `Debit`
  String get debit {
    return Intl.message(
      'Debit',
      name: 'debit',
      desc: '',
      args: [],
    );
  }

  /// `Save and proceed`
  String get save_and_proceed {
    return Intl.message(
      'Save and proceed',
      name: 'save_and_proceed',
      desc: '',
      args: [],
    );
  }

  /// `Select your zone`
  String get select_your_zone {
    return Intl.message(
      'Select your zone',
      name: 'select_your_zone',
      desc: '',
      args: [],
    );
  }

  /// `Profile image`
  String get profile_image {
    return Intl.message(
      'Profile image',
      name: 'profile_image',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle details`
  String get vehicle_details {
    return Intl.message(
      'Vehicle details',
      name: 'vehicle_details',
      desc: '',
      args: [],
    );
  }

  /// `Bike`
  String get bike {
    return Intl.message(
      'Bike',
      name: 'bike',
      desc: '',
      args: [],
    );
  }

  /// `Cycle`
  String get cycle {
    return Intl.message(
      'Cycle',
      name: 'cycle',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle model`
  String get vehicle_model {
    return Intl.message(
      'Vehicle model',
      name: 'vehicle_model',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle color`
  String get vehicle_color {
    return Intl.message(
      'Vehicle color',
      name: 'vehicle_color',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Swipe to accept the order`
  String get swipe_to_accept_the_order {
    return Intl.message(
      'Swipe to accept the order',
      name: 'swipe_to_accept_the_order',
      desc: '',
      args: [],
    );
  }

  /// `Please turn on your driving mode`
  String get please_turn_on_your_driving_mode {
    return Intl.message(
      'Please turn on your driving mode',
      name: 'please_turn_on_your_driving_mode',
      desc: '',
      args: [],
    );
  }

  /// `Restart your driving mode`
  String get restart_your_driving_mode {
    return Intl.message(
      'Restart your driving mode',
      name: 'restart_your_driving_mode',
      desc: '',
      args: [],
    );
  }

  /// `Iam on the way`
  String get iam_on_the_way {
    return Intl.message(
      'Iam on the way',
      name: 'iam_on_the_way',
      desc: '',
      args: [],
    );
  }

  /// `Low balance`
  String get low_balance {
    return Intl.message(
      'Low balance',
      name: 'low_balance',
      desc: '',
      args: [],
    );
  }

  /// `Your wallet balance is`
  String get your_wallet_balance_is {
    return Intl.message(
      'Your wallet balance is',
      name: 'your_wallet_balance_is',
      desc: '',
      args: [],
    );
  }

  /// `Request`
  String get request {
    return Intl.message(
      'Request',
      name: 'request',
      desc: '',
      args: [],
    );
  }

  /// `Enter the otp send to`
  String get enter_the_otp_send_to {
    return Intl.message(
      'Enter the otp send to',
      name: 'enter_the_otp_send_to',
      desc: '',
      args: [],
    );
  }

  /// `Password is not matched`
  String get password_is_not_matched {
    return Intl.message(
      'Password is not matched',
      name: 'password_is_not_matched',
      desc: '',
      args: [],
    );
  }

  /// `Select delivery location`
  String get select_delivery_location {
    return Intl.message(
      'Select delivery location',
      name: 'select_delivery_location',
      desc: '',
      args: [],
    );
  }

  /// `Please wait`
  String get please_wait {
    return Intl.message(
      'Please wait',
      name: 'please_wait',
      desc: '',
      args: [],
    );
  }

  /// `Please wait your document is under review`
  String get please_wait_your_document_is_under_review {
    return Intl.message(
      'Please wait your document is under review',
      name: 'please_wait_your_document_is_under_review',
      desc: '',
      args: [],
    );
  }

  /// `Should be valid email`
  String get should_be_valid_email {
    return Intl.message(
      'Should be valid email',
      name: 'should_be_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Should be more than 3 characters`
  String get should_be_more_than_3_characters {
    return Intl.message(
      'Should be more than 3 characters',
      name: 'should_be_more_than_3_characters',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'my'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
