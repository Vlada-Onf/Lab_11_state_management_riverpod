// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Mój Sklep';

  @override
  String get productsTitle => 'Produkty';

  @override
  String get cartTitle => 'Koszyk';

  @override
  String get allCategory => 'Wszystkie';

  @override
  String get addToCart => 'Dodaj';

  @override
  String addedToCart(String name) {
    return '$name dodano do koszyka';
  }

  @override
  String get cartEmpty => 'Koszyk jest pusty';

  @override
  String itemsLabel(int count) {
    return 'Produktów: $count';
  }

  @override
  String totalLabel(String total) {
    return 'Suma: $total';
  }

  @override
  String eachPrice(String price) {
    return '$price za sztukę';
  }

  @override
  String get checkout => 'Kup teraz';

  @override
  String get clearCart => 'Wyczyść koszyk';

  @override
  String get orderPlacedTitle => 'Zamówienie złożone';

  @override
  String get orderPlacedMessage => 'Twoje zamówienie zostało pomyślnie złożone!';

  @override
  String get ok => 'OK';

  @override
  String get settingsTab => 'Ustawienia';

  @override
  String get languageLabel => 'Język';

  @override
  String get selectLanguage => 'Wybierz język';

  @override
  String get ukrainian => 'Ukraiński';

  @override
  String get english => 'Angielski';

  @override
  String get polish => 'Polski';

  @override
  String get categoryPhone => 'Telefon';

  @override
  String get categoryLaptop => 'Laptop';

  @override
  String get categoryWatch => 'Zegarek';

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count produktów',
      many: '$count produktów',
      few: '$count produkty',
      one: '1 produkt',
      zero: 'Brak produktów',
    );
    return '$_temp0';
  }
}
