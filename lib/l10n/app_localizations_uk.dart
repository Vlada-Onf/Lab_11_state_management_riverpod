// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Мій магазин';

  @override
  String get productsTitle => 'Товари';

  @override
  String get cartTitle => 'Кошик';

  @override
  String get allCategory => 'Усі';

  @override
  String get addToCart => 'Додати';

  @override
  String addedToCart(String name) {
    return '$name додано до кошика';
  }

  @override
  String get cartEmpty => 'Кошик порожній';

  @override
  String itemsLabel(int count) {
    return 'Товарів: $count';
  }

  @override
  String totalLabel(String total) {
    return 'Сума: $total';
  }

  @override
  String eachPrice(String price) {
    return '$price за штуку';
  }

  @override
  String get checkout => 'Оформити замовлення';

  @override
  String get clearCart => 'Очистити кошик';

  @override
  String get orderPlacedTitle => 'Замовлення оформлено';

  @override
  String get orderPlacedMessage => 'Ваше замовлення успішно оформлено!';

  @override
  String get ok => 'OK';

  @override
  String get settingsTab => 'Налаштування';

  @override
  String get languageLabel => 'Мова';

  @override
  String get selectLanguage => 'Оберіть мову';

  @override
  String get ukrainian => 'Українська';

  @override
  String get english => 'Англійська';

  @override
  String get polish => 'Польська';

  @override
  String get categoryPhone => 'Телефон';

  @override
  String get categoryLaptop => 'Ноутбук';

  @override
  String get categoryWatch => 'Годинник';

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count товару',
      many: '$count товарів',
      few: '$count товари',
      one: '1 товар',
      zero: 'Немає товарів',
    );
    return '$_temp0';
  }
}
