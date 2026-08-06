import 'package:flutter/material.dart';

import '../../core/db/database.dart';

/// Curated icon catalog for categories.
///
/// Categories store an icon as [IconData.codePoint], but Flutter's release
/// build tree-shakes icon fonts down to the glyphs it can prove are used.
/// Rebuilding an `IconData` from a raw code point at runtime would therefore
/// render a blank box in release builds. Resolving through this const list
/// keeps every offered glyph reachable at compile time.
const categoryIcons = <IconData>[
  // Everyday spending
  Icons.restaurant,
  Icons.local_cafe,
  Icons.local_grocery_store,
  Icons.shopping_bag,
  Icons.checkroom,
  Icons.directions_bus,
  Icons.local_gas_station,
  Icons.directions_car,
  Icons.home,
  Icons.chair,
  Icons.receipt_long,
  Icons.bolt,
  Icons.water_drop,
  Icons.wifi,
  Icons.phone_iphone,
  Icons.local_hospital,
  Icons.medication,
  Icons.fitness_center,
  Icons.school,
  Icons.menu_book,
  Icons.sports_esports,
  Icons.movie,
  Icons.flight,
  Icons.hotel,
  Icons.card_giftcard,
  Icons.pets,
  Icons.child_care,
  Icons.cut,
  Icons.build,
  Icons.cleaning_services,
  // Income and finance
  Icons.payments,
  Icons.work_outline,
  Icons.trending_up,
  Icons.savings,
  Icons.account_balance,
  Icons.currency_exchange,
  Icons.percent,
  // System / misc
  Icons.handshake_outlined,
  Icons.volunteer_activism,
  Icons.tune,
  Icons.swap_horiz,
  Icons.help_outline,
  Icons.category_outlined,
  Icons.star_border,
];

/// Palette offered in the category form. Stored as an ARGB int.
const categoryColors = <Color>[
  Color(0xFFE53935), // red
  Color(0xFFD81B60), // pink
  Color(0xFF8E24AA), // purple
  Color(0xFF5E35B1), // deep purple
  Color(0xFF3949AB), // indigo
  Color(0xFF1E88E5), // blue
  Color(0xFF039BE5), // light blue
  Color(0xFF00ACC1), // cyan
  Color(0xFF00897B), // teal
  Color(0xFF43A047), // green
  Color(0xFF7CB342), // light green
  Color(0xFFC0CA33), // lime
  Color(0xFFFDD835), // yellow
  Color(0xFFFFB300), // amber
  Color(0xFFFB8C00), // orange
  Color(0xFFF4511E), // deep orange
  Color(0xFF6D4C41), // brown
  Color(0xFF757575), // grey
  Color(0xFF546E7A), // blue grey
];

const _fallbackIcon = Icons.category_outlined;

/// Resolves a stored code point back to a const [IconData]. Falls back to a
/// neutral icon when the stored value isn't in [categoryIcons] (e.g. a row
/// seeded by an older build whose glyph was later dropped).
IconData categoryIconFor(int? codePoint) {
  if (codePoint == null) return _fallbackIcon;
  for (final icon in categoryIcons) {
    if (icon.codePoint == codePoint) return icon;
  }
  return _fallbackIcon;
}

/// Resolves a stored ARGB value, falling back to the theme's primary color.
Color categoryColorFor(int? value, BuildContext context) {
  if (value == null) return Theme.of(context).colorScheme.primary;
  return Color(value);
}

extension CategoryStyle on Category {
  IconData get icon => categoryIconFor(iconCode);

  Color color(BuildContext context) => categoryColorFor(colorValue, context);
}

/// Persian label for a [CategoryKind], used in forms and section headers.
String categoryKindLabel(CategoryKind kind) => switch (kind) {
      CategoryKind.expense => 'هزینه',
      CategoryKind.income => 'درآمد',
      CategoryKind.both => 'هر دو',
    };
