import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tatweer_approval/widgets/custom_progreess_indicator.dart';
import 'package:placeholder_images/placeholder_images.dart';

import '../../providers/user_provider.dart';

class WelcomeBar extends ConsumerStatefulWidget {
  const WelcomeBar({super.key});

  @override
  ConsumerState<WelcomeBar> createState() {
    return _WelcomeBarStatus();
  }
}

class _WelcomeBarStatus extends ConsumerState<WelcomeBar> {
  var _isLoading = false;

  void disableLoadingSpinner() async {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Builder(
          builder: (context) => InkWell(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: CircleAvatar(
                radius: 38,
                child: FadeInImage.assetNetwork(
                  placeholder: PlaceholderImage.getPlaceholderImageURL(
                      userInfo['displayName'],
                      rounded: true,
                      backgroundColor: '#ffffff'),
                  image: '',
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      PlaceholderImage.getPlaceholderImageURL(
                          userInfo['displayName'],
                          rounded: true,
                          backgroundColor: '#ffffff'),
                    );
                  },
                ),
              ),
            ),
            onTap: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Good Day',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.waving_hand_rounded,
                    color: Color.fromRGBO(224, 155, 26, 1),
                  ),
                ],
              ),
              Text(
                userInfo['displayName'],
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              ref
                  .read(userProvider.notifier)
                  .logOut(disableLoadingSpinner);
            },
            icon: _isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: Center(
                        child: CustomProgreessIndicator()),
                  )
                : const Icon(
                    Icons.exit_to_app_rounded,
                    size: 30,
                  ))
      ],
    );
  }
}
