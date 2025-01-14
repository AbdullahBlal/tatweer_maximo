import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placeholder_images/placeholder_images.dart';
import '../../providers/user_provider.dart';
import 'package:badges/badges.dart' as badges;

class MainAppBar extends ConsumerStatefulWidget {
  const MainAppBar(
      {super.key, required this.content, required this.notifications});
  final Widget content;
  final List notifications;

  @override
  ConsumerState<MainAppBar> createState() {
    return _MainAppBarStatus();
  }
}

class _MainAppBarStatus extends ConsumerState<MainAppBar> {
  var isLoading = false;
  var userInfo = {};

  void disableLoadingSpinner() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  // ignore: must_call_super
  void initState() {
    userInfo = ref.read(userProvider.notifier).getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Row(
              children: [
                Builder(
                  builder: (context) => InkWell(
                    child: CircleAvatar(
                      radius: 27,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: ClipOval(
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          radius: 25,
                          child: Image.network(
                            userInfo["profileImageUrl"],
                            headers: <String, String>{
                              'apikey': userInfo["apikey"],
                            },
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                PlaceholderImage.getPlaceholderImageURL(
                                    userInfo['personid'],
                                    rounded: true,
                                    backgroundColor: '#fff'),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    onTap: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 170,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      userInfo["displayname"],
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.notifications.isNotEmpty
                      ? badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                              badgeColor:
                                  Theme.of(context).colorScheme.tertiary),
                          position:
                              badges.BadgePosition.topEnd(top: 0, end: 10),
                          badgeContent: Text(
                            widget.notifications.length.toString(),
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w900),
                          ),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                color: Theme.of(context).colorScheme.secondary,
                                Icons.notifications,
                                size: 25,
                              )),
                        )
                      : IconButton(
                          onPressed: () {},
                          icon: Icon(
                            color: Theme.of(context).colorScheme.primary,
                            Icons.notifications,
                            size: 25,
                          )),
                ],
              ),
            )
          ],
        ),
        widget.content
      ],
    );
  }
}
