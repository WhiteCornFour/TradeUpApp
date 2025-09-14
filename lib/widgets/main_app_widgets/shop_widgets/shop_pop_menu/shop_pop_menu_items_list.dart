import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_pop_menu/shop_pop_menu_item.dart';

class PopMenuItemsListShop {
  static const List<PopMenuItemShop> itemsFirst = [
    itemNews,
    itemOld,
    itemRelevance,
  ];

  static const itemNews = PopMenuItemShop(text: 'Newest', icon: Iconsax.sort);

  static const itemOld = PopMenuItemShop(
    text: 'Oldest',
    icon: Iconsax.backward,
  );

  static const itemRelevance = PopMenuItemShop(
    text: 'Relevance',
    icon: Iconsax.filter,
  );
}
