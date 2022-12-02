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

  /// `Today earn`
  String get today_earn {
    return Intl.message(
      'Today earn',
      name: 'today_earn',
      desc: '',
      args: [],
    );
  }

  /// `On`
  String get on {
    return Intl.message(
      'On',
      name: 'on',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get off {
    return Intl.message(
      'Off',
      name: 'off',
      desc: '',
      args: [],
    );
  }

  /// `Last `
  String get last {
    return Intl.message(
      'Last ',
      name: 'last',
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

  /// `This month`
  String get this_month {
    return Intl.message(
      'This month',
      name: 'this_month',
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

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
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

  /// `Light Mode`
  String get light_mode {
    return Intl.message(
      'Light Mode',
      name: 'light_mode',
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

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
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

  /// `Full name`
  String get full_name {
    return Intl.message(
      'Full name',
      name: 'full_name',
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

  /// `if you don't have account`
  String get if_you_dont_have_account {
    return Intl.message(
      'if you don\'t have account',
      name: 'if_you_dont_have_account',
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

  /// `App language`
  String get app_language {
    return Intl.message(
      'App language',
      name: 'app_language',
      desc: '',
      args: [],
    );
  }

  /// `Select your preferred languages`
  String get select_your_preferred_languages {
    return Intl.message(
      'Select your preferred languages',
      name: 'select_your_preferred_languages',
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

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
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

  /// `Total earn`
  String get total_earn {
    return Intl.message(
      'Total earn',
      name: 'total_earn',
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

  /// `Today orders`
  String get today_orders {
    return Intl.message(
      'Today orders',
      name: 'today_orders',
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

  /// `My schedule`
  String get my_schedule {
    return Intl.message(
      'My schedule',
      name: 'my_schedule',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `My appointment`
  String get my_appointment {
    return Intl.message(
      'My appointment',
      name: 'my_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Experience`
  String get experience {
    return Intl.message(
      'Experience',
      name: 'experience',
      desc: '',
      args: [],
    );
  }

  /// `quick pitch`
  String get quick_pitch {
    return Intl.message(
      'quick pitch',
      name: 'quick_pitch',
      desc: '',
      args: [],
    );
  }

  /// `Price per hour`
  String get price_per_hour {
    return Intl.message(
      'Price per hour',
      name: 'price_per_hour',
      desc: '',
      args: [],
    );
  }

  /// `Add category`
  String get add_category {
    return Intl.message(
      'Add category',
      name: 'add_category',
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

  /// `My raiged`
  String get my_raiged {
    return Intl.message(
      'My raiged',
      name: 'my_raiged',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your experience`
  String get please_enter_your_experience {
    return Intl.message(
      'Please enter your experience',
      name: 'please_enter_your_experience',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your price`
  String get please_enter_your_price {
    return Intl.message(
      'Please enter your price',
      name: 'please_enter_your_price',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your quick pitch`
  String get please_enter_your_quick_pitch {
    return Intl.message(
      'Please enter your quick pitch',
      name: 'please_enter_your_quick_pitch',
      desc: '',
      args: [],
    );
  }

  /// `Booking history`
  String get booking_history {
    return Intl.message(
      'Booking history',
      name: 'booking_history',
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

  /// `Process`
  String get process {
    return Intl.message(
      'Process',
      name: 'process',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get bio {
    return Intl.message(
      'Bio',
      name: 'bio',
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

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
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

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
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

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
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

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
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

  /// `Transgender`
  String get transgender {
    return Intl.message(
      'Transgender',
      name: 'transgender',
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

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
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

  /// `Prev`
  String get prev {
    return Intl.message(
      'Prev',
      name: 'prev',
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

  /// `Please enter your city`
  String get please_enter_your_city {
    return Intl.message(
      'Please enter your city',
      name: 'please_enter_your_city',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your state`
  String get please_enter_your_state {
    return Intl.message(
      'Please enter your state',
      name: 'please_enter_your_state',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your pincode`
  String get please_enter_your_pincode {
    return Intl.message(
      'Please enter your pincode',
      name: 'please_enter_your_pincode',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get email_address {
    return Intl.message(
      'Email address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Mobile number`
  String get mobile_number {
    return Intl.message(
      'Mobile number',
      name: 'mobile_number',
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

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Work experience`
  String get work_experience {
    return Intl.message(
      'Work experience',
      name: 'work_experience',
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

  /// `Please enter your work experience`
  String get please_enter_your_work_experience {
    return Intl.message(
      'Please enter your work experience',
      name: 'please_enter_your_work_experience',
      desc: '',
      args: [],
    );
  }

  /// `Please enter about you`
  String get please_enter_about_you {
    return Intl.message(
      'Please enter about you',
      name: 'please_enter_about_you',
      desc: '',
      args: [],
    );
  }

  /// `Upload your pic`
  String get upload_your_pic {
    return Intl.message(
      'Upload your pic',
      name: 'upload_your_pic',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `version`
  String get version {
    return Intl.message(
      'version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Sorry your account is blocked`
  String get sorry_your_account_is_blocked {
    return Intl.message(
      'Sorry your account is blocked',
      name: 'sorry_your_account_is_blocked',
      desc: '',
      args: [],
    );
  }

  /// `Please contact`
  String get please_contact {
    return Intl.message(
      'Please contact',
      name: 'please_contact',
      desc: '',
      args: [],
    );
  }

  /// `Take a photo`
  String get take_a_photo {
    return Intl.message(
      'Take a photo',
      name: 'take_a_photo',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Booking track`
  String get booking_track {
    return Intl.message(
      'Booking track',
      name: 'booking_track',
      desc: '',
      args: [],
    );
  }

  /// `Test`
  String get test {
    return Intl.message(
      'Test',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `Book id`
  String get book_id {
    return Intl.message(
      'Book id',
      name: 'book_id',
      desc: '',
      args: [],
    );
  }

  /// `Subcategory name`
  String get subcategoryname {
    return Intl.message(
      'Subcategory name',
      name: 'subcategoryname',
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

  /// `On the way`
  String get on_the_way {
    return Intl.message(
      'On the way',
      name: 'on_the_way',
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

  /// `Hours`
  String get hours {
    return Intl.message(
      'Hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Booking status`
  String get booking_status {
    return Intl.message(
      'Booking status',
      name: 'booking_status',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
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

  /// `Date & time`
  String get date_time {
    return Intl.message(
      'Date & time',
      name: 'date_time',
      desc: '',
      args: [],
    );
  }

  /// `Tracking system`
  String get tracking_system {
    return Intl.message(
      'Tracking system',
      name: 'tracking_system',
      desc: '',
      args: [],
    );
  }

  /// `Service booked`
  String get service_booked {
    return Intl.message(
      'Service booked',
      name: 'service_booked',
      desc: '',
      args: [],
    );
  }

  /// `Provider approved`
  String get provider_approved {
    return Intl.message(
      'Provider approved',
      name: 'provider_approved',
      desc: '',
      args: [],
    );
  }

  /// `Job started`
  String get job_started {
    return Intl.message(
      'Job started',
      name: 'job_started',
      desc: '',
      args: [],
    );
  }

  /// `Job completed`
  String get job_completed {
    return Intl.message(
      'Job completed',
      name: 'job_completed',
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

  /// `Debug`
  String get debug {
    return Intl.message(
      'Debug',
      name: 'debug',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get forgot_password {
    return Intl.message(
      'Forgot password',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Booking id`
  String get booking_id {
    return Intl.message(
      'Booking id',
      name: 'booking_id',
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

  /// `Don’t receive otp send otp`
  String get dont_receive_otp_send_otp {
    return Intl.message(
      'Don’t receive otp send otp',
      name: 'dont_receive_otp_send_otp',
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

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get registration {
    return Intl.message(
      'Registration',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `New request`
  String get new_request {
    return Intl.message(
      'New request',
      name: 'new_request',
      desc: '',
      args: [],
    );
  }

  /// `Payment confirmation`
  String get payment_confirmation {
    return Intl.message(
      'Payment confirmation',
      name: 'payment_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Confirm when user paid the full amount`
  String get confirm_when_user_paid_the_full_amount {
    return Intl.message(
      'Confirm when user paid the full amount',
      name: 'confirm_when_user_paid_the_full_amount',
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

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Thank you`
  String get thank_you {
    return Intl.message(
      'Thank you',
      name: 'thank_you',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your registration`
  String get thank_you_for_your_registration {
    return Intl.message(
      'Thank you for your registration',
      name: 'thank_you_for_your_registration',
      desc: '',
      args: [],
    );
  }

  /// `Item name`
  String get item_name {
    return Intl.message(
      'Item name',
      name: 'item_name',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
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

  /// `Delivery address removed sucessfully`
  String get delivery_address_removed_successfully {
    return Intl.message(
      'Delivery address removed sucessfully',
      name: 'delivery_address_removed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `You are online`
  String get you_are_online {
    return Intl.message(
      'You are online',
      name: 'you_are_online',
      desc: '',
      args: [],
    );
  }

  /// `You are offline`
  String get you_are_offline {
    return Intl.message(
      'You are offline',
      name: 'you_are_offline',
      desc: '',
      args: [],
    );
  }

  /// `Successfully completed`
  String get successfully_completed {
    return Intl.message(
      'Successfully completed',
      name: 'successfully_completed',
      desc: '',
      args: [],
    );
  }

  /// `Cannot be close before you complete`
  String get cannot_be_close_before_you_complete {
    return Intl.message(
      'Cannot be close before you complete',
      name: 'cannot_be_close_before_you_complete',
      desc: '',
      args: [],
    );
  }

  /// `This account is not exit`
  String get this_account_is_not_exit {
    return Intl.message(
      'This account is not exit',
      name: 'this_account_is_not_exit',
      desc: '',
      args: [],
    );
  }

  /// `This notification has marked as un read`
  String get this_notification_has_marked_as_un_read {
    return Intl.message(
      'This notification has marked as un read',
      name: 'this_notification_has_marked_as_un_read',
      desc: '',
      args: [],
    );
  }

  /// `Notification was removed`
  String get notification_was_removed {
    return Intl.message(
      'Notification was removed',
      name: 'notification_was_removed',
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

  /// `Create your account to continue`
  String get create_your_account_to_continue {
    return Intl.message(
      'Create your account to continue',
      name: 'create_your_account_to_continue',
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

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid number`
  String get not_a_valid_number {
    return Intl.message(
      'Not a valid number',
      name: 'not_a_valid_number',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Price per hrs`
  String get price_per_hrs {
    return Intl.message(
      'Price per hrs',
      name: 'price_per_hrs',
      desc: '',
      args: [],
    );
  }

  /// `Service accepted`
  String get service_accepted {
    return Intl.message(
      'Service accepted',
      name: 'service_accepted',
      desc: '',
      args: [],
    );
  }

  /// `Started to customer place`
  String get started_to_customer_place {
    return Intl.message(
      'Started to customer place',
      name: 'started_to_customer_place',
      desc: '',
      args: [],
    );
  }

  /// `Provider arrived`
  String get provider_arrived {
    return Intl.message(
      'Provider arrived',
      name: 'provider_arrived',
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

  /// `Billing details`
  String get billing_details {
    return Intl.message(
      'Billing details',
      name: 'billing_details',
      desc: '',
      args: [],
    );
  }

  /// `Provider name`
  String get provider_name {
    return Intl.message(
      'Provider name',
      name: 'provider_name',
      desc: '',
      args: [],
    );
  }

  /// `Billing name`
  String get billing_name {
    return Intl.message(
      'Billing name',
      name: 'billing_name',
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

  /// `Worked hours`
  String get worked_hours {
    return Intl.message(
      'Worked hours',
      name: 'worked_hours',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
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

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
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

  /// `Address 1`
  String get address_1 {
    return Intl.message(
      'Address 1',
      name: 'address_1',
      desc: '',
      args: [],
    );
  }

  /// `Address 2`
  String get address_2 {
    return Intl.message(
      'Address 2',
      name: 'address_2',
      desc: '',
      args: [],
    );
  }

  /// `Take photo`
  String get take_photo {
    return Intl.message(
      'Take photo',
      name: 'take_photo',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the item name`
  String get please_enter_the_item_name {
    return Intl.message(
      'Please enter the item name',
      name: 'please_enter_the_item_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the price amount`
  String get please_enter_the_price_amount {
    return Intl.message(
      'Please enter the price amount',
      name: 'please_enter_the_price_amount',
      desc: '',
      args: [],
    );
  }

  /// `Addresses refereshed successfully`
  String get addresses_referenced_successfully {
    return Intl.message(
      'Addresses refereshed successfully',
      name: 'addresses_referenced_successfully',
      desc: '',
      args: [],
    );
  }

  /// `New address added successfully`
  String get new_address_added_successfully {
    return Intl.message(
      'New address added successfully',
      name: 'new_address_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `The address updated successfully`
  String get the_address_updated_successfully {
    return Intl.message(
      'The address updated successfully',
      name: 'the_address_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Notification refereshed successfully`
  String get notification_referenced_successfully {
    return Intl.message(
      'Notification refereshed successfully',
      name: 'notification_referenced_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Profile settings updated successfully`
  String get profile_settings_updated_successfully {
    return Intl.message(
      'Profile settings updated successfully',
      name: 'profile_settings_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid full number`
  String get not_a_valid_full_number {
    return Intl.message(
      'Not a valid full number',
      name: 'not_a_valid_full_number',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid email`
  String get not_a_valid_email {
    return Intl.message(
      'Not a valid email',
      name: 'not_a_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid phone`
  String get not_a_valid_phone {
    return Intl.message(
      'Not a valid phone',
      name: 'not_a_valid_phone',
      desc: '',
      args: [],
    );
  }

  /// `Your address`
  String get your_address {
    return Intl.message(
      'Your address',
      name: 'your_address',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid address`
  String get not_a_valid_address {
    return Intl.message(
      'Not a valid address',
      name: 'not_a_valid_address',
      desc: '',
      args: [],
    );
  }

  /// `Your biography`
  String get your_biography {
    return Intl.message(
      'Your biography',
      name: 'your_biography',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid biography`
  String get not_a_valid_biography {
    return Intl.message(
      'Not a valid biography',
      name: 'not_a_valid_biography',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Trans`
  String get trans {
    return Intl.message(
      'Trans',
      name: 'trans',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
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

  /// `Miscellaneous amount (click)`
  String get miscellaneous_amount_click {
    return Intl.message(
      'Miscellaneous amount (click)',
      name: 'miscellaneous_amount_click',
      desc: '',
      args: [],
    );
  }

  /// `About you`
  String get about_you {
    return Intl.message(
      'About you',
      name: 'about_you',
      desc: '',
      args: [],
    );
  }

  /// `This notification has marked as read`
  String get this_notification_has_marked_as_read {
    return Intl.message(
      'This notification has marked as read',
      name: 'this_notification_has_marked_as_read',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid full name`
  String get not_a_valid_full_name {
    return Intl.message(
      'Not a valid full name',
      name: 'not_a_valid_full_name',
      desc: '',
      args: [],
    );
  }

  /// `Miscellaneous amount`
  String get miscellaneous_amount {
    return Intl.message(
      'Miscellaneous amount',
      name: 'miscellaneous_amount',
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

  /// `Invalid email`
  String get invalid_email {
    return Intl.message(
      'Invalid email',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password`
  String get enter_your_new_password {
    return Intl.message(
      'Enter your new password',
      name: 'enter_your_new_password',
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

  /// `Recent transactions`
  String get recent_transactions {
    return Intl.message(
      'Recent transactions',
      name: 'recent_transactions',
      desc: '',
      args: [],
    );
  }

  /// `Transaction history`
  String get transaction_history {
    return Intl.message(
      'Transaction history',
      name: 'transaction_history',
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

  /// `Please your document is under review`
  String get please_wait_your_document_is_under_review {
    return Intl.message(
      'Please your document is under review',
      name: 'please_wait_your_document_is_under_review',
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

  /// `Save and proceed`
  String get save_and_proceed {
    return Intl.message(
      'Save and proceed',
      name: 'save_and_proceed',
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
