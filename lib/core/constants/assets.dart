class Assets {
  static const icons = _Icons();
  static const images = _Images();
  static const illustrations = _Illustrations();
  static const logos = _Logos();
  static const svg = _SVGs();
  static final animations = _Animations();
}

class _Animations {
  _Animations();
  final String path = 'assets/animations/';
  String get landingPage => '$path/landing_page.json';

  final lottie = _LottieAnimations();
}

class _LottieAnimations {
  _LottieAnimations();
  final String path = 'assets/animations/lottie/';
  final loading = const _LottieLoadingAnimations();
}

class _LottieLoadingAnimations {
  const _LottieLoadingAnimations();
  final String path = 'assets/animations/lottie/loading/';

  String get loading => '$path/loading.lottie';
  String get loading2 => '$path/8.lottie';
}

class _Illustrations {
  final String path = 'assets/svg/illustrations/';
  const _Illustrations();
}

class _Images {
  final String path = 'assets/images/';
  const _Images();
}

class _Logos {
  final String path = 'assets/svg/';
  const _Logos();
  String get mojaTextLogoLight => '${path}moja_text_log_light.svg';
  String get mojaTextLogoDark => '${path}moja_text_log_dark.svg';
  String get logo => '${path}logo.svg';
}

class _SVGs {
  final String path = 'assets/svg/';
  const _SVGs();
}

class _Icons {
  final String path = 'assets/svg/';
  const _Icons();
  String get visaLogo => '${path}visa-logo.svg';
  String get mastercardLogo => '${path}mastercard-logo.svg';
  String get list => '${path}arrow_vertical.svg';
  String get messages => '${path}messages.svg';
  String get settings => '${path}settings.svg';
  String get profile => '${path}profile.svg';
  String get arrowRightIcon => '${path}arrow_right.svg';
  String get apple => '${path}apple_icon.svg';
  String get google => '${path}google_icon.svg';
  String get location => '${path}location.svg';
  String get registerFinishBackground => '${path}register_finish.svg';
  String get done => '${path}done.svg';
  String get copy => '${path}copy.svg';
  String get messageQuestion => '${path}message_question.svg';
  String get edit => '${path}edit.svg';
  String get help => '${path}help.svg';
  String get storage => '${path}storage.svg';
  String get storageAndData => '${path}storage_and_data.svg';
  String get language => '${path}language.svg';
  String get appAndLanguages => '${path}app_and_languages.svg';
  String get simCard => '${path}sim_card.svg';
  String get connected => '${path}connected.svg';
  String get info => '${path}info.svg';
  String get infoCircle => '${path}info_circle.svg';
  String get person => '${path}person.svg';
  String get rewards => '${path}rewards.svg';
  String get security => '${path}security.svg';
  String get notificationSettings => '${path}notification_settings.svg';
  String get channels => '${path}channels.svg';
  String get search => '${path}search.svg';
  String get ukFlag => '${path}uk_flag.svg';
  String get arFlag => '${path}ar_flag.svg';
  String get kuFlag => '${path}ku_flag.svg';
  String get personProfile => '${path}person_profile.svg';
  String get warning => '${path}warning.svg';
  String get filter => '${path}filter.svg';
  String get muteNotifications => '${path}mute_notification.svg';
  String get signOut => '${path}log_out.svg';
  String get link => '${path}link.svg';
  String get lock => '${path}lock_keyhole.svg';
  String get shieldCheck => '${path}shield_check.svg';
  String get simpleLike => '${path}simple_like_hand.svg';
  String get hand => '${path}hand.svg';
  String get arrowRight => '${path}arrow_right.svg';
  String get warningCircle => '${path}warning_circle.svg';
  String get unlink => '${path}unlink.svg';
  String get phone => '${path}phone.svg';
  String get delete => '${path}delete.svg';
  String get mobile => '${path}mobile.svg';
  String get money => '${path}money.svg';
  String get export => '${path}export.svg';
  String get calendar => '${path}calendar.svg';
  String get eye => '${path}eye_visible.svg';
  String get eyeOff => '${path}eye_visible_off.svg';
  String get file => '${path}file.svg';
  String get imageFailPlaceholder => '${path}image_fail_placeholder.jpg';
  String get checkBox => '${path}check_box.svg';
  String get checkBoxBlank => '${path}check_box_blank.svg';
}
