import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_pop_menu/shop_pop_menu_item.dart';

class PopMenuItemsList {
  static const List<PopMenuItem> itemsFirst = [
    itemNews,
    itemOld,
    itemRelevance,
  ];

  static const itemNews = PopMenuItem(text: 'Newest', icon: Iconsax.sort);

  static const itemOld = PopMenuItem(text: 'Oldest', icon: Iconsax.backward);

  static const itemRelevance = PopMenuItem(
    text: 'Relevance',
    icon: Iconsax.filter,
  );
}
