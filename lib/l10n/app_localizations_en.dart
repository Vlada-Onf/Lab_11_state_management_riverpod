// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My Store';

  @override
  String get productsTitle => 'Products';

  @override
  String get cartTitle => 'Shopping Cart';

  @override
  String get allCategory => 'All';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String addedToCart(String name) {
    return '$name added to cart';
  }

  @override
  String get cartEmpty => 'Cart is empty';

  @override
  String itemsLabel(int count) {
    return 'Items: $count';
  }

  @override
  String totalLabel(String total) {
    return 'Total: $total';
  }

  @override
  String eachPrice(String price) {
    return '$price each';
  }

  @override
  String get checkout => 'Checkout';

  @override
  String get clearCart => 'Clear cart';

  @override
  String get orderPlacedTitle => 'Order placed';

  @override
  String get orderPlacedMessage => 'Your order has been successfully placed!';

  @override
  String get ok => 'OK';

  @override
  String get settingsTab => 'Settings';

  @override
  String get languageLabel => 'Language';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get ukrainian => 'Ukrainian';

  @override
  String get english => 'English';

  @override
  String get polish => 'Polish';

  @override
  String get categoryPhone => 'Phone';

  @override
  String get categoryLaptop => 'Laptop';

  @override
  String get categoryWatch => 'Watch';

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }
}
