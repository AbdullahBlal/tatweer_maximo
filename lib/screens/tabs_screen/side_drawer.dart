import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tatweer_approval/models/security_group.dart';
import 'package:tatweer_approval/providers/user_provider.dart';
import 'package:tatweer_approval/widgets/custom_progreess_indicator.dart';
import 'package:placeholder_images/placeholder_images.dart';

class SideDrawer extends ConsumerStatefulWidget {
  const SideDrawer(
      {super.key,
      required this.getTotalRecords,
      required this.navigateToPage,
      required this.apiKey,
      required this.currentSC});

  final Function getTotalRecords;
  final Function navigateToPage;
  final String apiKey;
  final String currentSC;

  @override
  ConsumerState<SideDrawer> createState() {
    return _SideDrawerState();
  }
}

class _SideDrawerState extends ConsumerState<SideDrawer> {
  var _isLoading = false;
  List<SecurityGroup> securityGroups = [];

  @override
  void initState() {
    securityGroups = ref.read(userProvider.notifier).getSecurityGroups();
    securityGroups.sort((a, b) => b.mobileSCWeight.compareTo(a.mobileSCWeight));
    super.initState();
  }

  void disableLoadingSpinner() async {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userProvider);
    return Drawer(
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.zero),
      ),
      backgroundColor: const Color.fromRGBO(243, 245, 247, 1),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: DrawerHeader(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.tertiary
              ])),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: ClipOval(
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        radius: 38,
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
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 170,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        userInfo["displayname"],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    for (SecurityGroup securityGroup in securityGroups)
                      InkWell(
                        onTap: () async {
                          widget.navigateToPage(0);
                          Navigator.of(context).pop();
                          ref
                              .read(userProvider.notifier)
                              .setCurrentSG(securityGroup);
                          widget.getTotalRecords();
                        },
                        child: Column(
                          children: [
                            ListTile(
                              selected:
                                  widget.currentSC == securityGroup.mobileSC,
                              selectedColor:
                                  Theme.of(context).colorScheme.secondary,
                              selectedTileColor:
                                  Theme.of(context).colorScheme.tertiary,
                              tileColor: Theme.of(context).colorScheme.tertiary,
                              leading: Text(securityGroup.mobileSC,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                              title: Text(securityGroup.mobileSCDescription,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400)),
                            ),
                            const SizedBox(height: 2)
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isLoading = true;
                        });
                        ref
                            .read(userProvider.notifier)
                            .logOut(disableLoadingSpinner);
                      },
                      child: _isLoading
                          ? ListTile(
                              tileColor: Theme.of(context).colorScheme.primary,
                              leading: const SizedBox(
                                width: 16,
                                height: 16,
                                child:
                                    Center(child: CustomProgreessIndicator()),
                              ))
                          : ListTile(
                              tileColor: Theme.of(context).colorScheme.primary,
                              leading: Icon(
                                Icons.exit_to_app_rounded,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              title: Text('Log Out',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontWeight: FontWeight.w500)),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
