import 'package:flutter/material.dart';
import 'package:tatweer_maximo/widgets/search_input.dart';

class MainAppBarContent extends StatelessWidget {
  const MainAppBarContent({super.key, required this.itemSelected, required this.onSearchTextChange});
  final Function onSearchTextChange;
  final int itemSelected;

  @override
  Widget build(BuildContext context) {
    String pageTitle = 'Home';
    String searchBy = '';
    if (itemSelected == 2) {
      pageTitle = 'Help';
    }

    if (itemSelected == 3) {
      pageTitle = 'Purchase Requests';
      searchBy = '(PR #, Dept, Details)';
    }

    if (itemSelected == 4) {
      pageTitle = 'Purchase Orders';
      searchBy = '(PO #, Dept, Details)';
    }

    if (itemSelected == 5) {
      pageTitle = 'Workorders';
      searchBy = '(WO #, Details)';
    }

    return Column(
      children: [
        Row(
          children: [
            itemSelected != 0 && itemSelected != 2
                ? Text(
                    pageTitle,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        height:2,
                        fontWeight: FontWeight.w400),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        itemSelected != 0 && itemSelected != 2
            ? SearchInput(label:pageTitle, onSearchTextChange:onSearchTextChange, searchableItem:itemSelected, searchBy: searchBy,)
            : const SizedBox.shrink(),
      ],
    );
  }
}
