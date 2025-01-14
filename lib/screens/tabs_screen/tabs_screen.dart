import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:tatweer_approval/models/main_card.dart';
import 'package:tatweer_approval/models/purchase_order.dart';
import 'package:tatweer_approval/models/purchase_request.dart';
import 'package:tatweer_approval/models/workorder.dart';
import 'package:tatweer_approval/providers/purchase_order_provider.dart';
import 'package:tatweer_approval/providers/purchase_request_provider.dart';
import 'package:tatweer_approval/providers/user_provider.dart';
import 'package:tatweer_approval/providers/workorders_provider.dart';
import 'package:tatweer_approval/screens/about_screen/about_screen.dart';
import 'package:tatweer_approval/screens/home_screen/home_screen.dart';
import 'package:tatweer_approval/screens/purchase_orders_screen/purchase_orders_screen.dart';
import 'package:tatweer_approval/screens/purchase_requests_screen/purchase_requests_screen.dart';
import 'package:tatweer_approval/screens/tabs_screen/main_app_bar.dart';
import 'package:tatweer_approval/screens/tabs_screen/main_app_bar_content.dart';
import 'package:tatweer_approval/screens/tabs_screen/side_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tatweer_approval/screens/workorders_screen/workorders_screen.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  List<MainCard> cardsContent = [];
  int _selectedPageIndex = 0;
  String apiKey = "";
  String currentSC = "";
  var _isLoading = false;
  List notifications = [];
  List<PurchaseRequest> purchaseRequests = [];
  List<PurchaseOrder> purchaseOrders = [];
  List<Workorder> workorders = [];
  bool loadingPurchaseOrders = false;
  bool loadingPurchaseRequests = false;
  bool loadingWorkorders = false;

  void navigateToPage(int index) {
    if (index == 3) {
      loadPurchaseRequests();
    }
    if (index == 4) {
      loadPurchaseOrders();
    }
    if (index == 5) {
      loadWorkorders();
    }
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void selectScreen(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    apiKey = ref.read(userProvider.notifier).getApiKey();
    getTotalRecords();
    super.initState();
  }

  void getTotalRecords() async {
    setState(() {
      _isLoading = true;
      currentSC = ref.read(userProvider.notifier).getCurrentSC();
    });
    final workordersTotal = await ref
        .read(workordersProvider.notifier)
        .getTotalCount(apiKey, currentSC);
    final purchaseOrdersTotal = await ref
        .read(purchaseOrdersProvider.notifier)
        .getTotalCount(apiKey, currentSC);
    final purchaseRequestsTotal = await ref
        .read(purchaseRequestsProvider.notifier)
        .getTotalCount(apiKey, currentSC);
    if (mounted) {
      setState(() {
        cardsContent = [
          MainCard(
            iconPath: 'assets/images/purchase-request.png',
            title: 'Purchase Requests',
            recordsTotal: purchaseRequestsTotal,
            index: 3,
          ),
          MainCard(
            iconPath: 'assets/images/purchase-order.png',
            title: 'Purchase Orders',
            recordsTotal: purchaseOrdersTotal,
            index: 4,
          ),
          MainCard(
            iconPath: 'assets/images/purchase-order.png',
            title: 'Workorders',
            recordsTotal: workordersTotal,
            index: 5,
          ),
        ];
        _isLoading = false;
      });
    }
  }

  Future<void> loadWorkorders() async {
    setState(() {
      loadingWorkorders = true;
    });
    final loadedWorkorders = await ref
        .read(workordersProvider.notifier)
        .getWorkorders(apiKey, currentSC);
    if (mounted) {
      setState(() {
        workorders = loadedWorkorders;
        loadingWorkorders = false;
      });
    }
  }

  Future<void> refreshWorkorders() async {
    final loadedWorkorders = await ref
        .read(workordersProvider.notifier)
        .getWorkorders(apiKey, currentSC);
    if (mounted) {
      setState(() {
        workorders = loadedWorkorders;
      });
    }
  }

  Future<void> loadPurchaseOrders() async {
    setState(() {
      loadingPurchaseOrders = true;
    });
    final loadedPurchaseOrders = await ref
        .read(purchaseOrdersProvider.notifier)
        .getPurchaseOrders(apiKey, currentSC);
    if (mounted) {
      setState(() {
        purchaseOrders = loadedPurchaseOrders;
        loadingPurchaseOrders = false;
      });
    }
  }

  Future<void> refreshPurchaseOrders() async {
    final loadedPurchaseOrders = await ref
        .read(purchaseOrdersProvider.notifier)
        .getPurchaseOrders(apiKey, currentSC);
    if (mounted) {
      setState(() {
        purchaseOrders = loadedPurchaseOrders;
      });
    }
  }

  Future<void> loadPurchaseRequests() async {
    setState(() {
      loadingPurchaseRequests = true;
    });
    final loadedPurchaseRequests = await ref
        .read(purchaseRequestsProvider.notifier)
        .getPurchaseRequests(apiKey, currentSC);
    if (mounted) {
      setState(() {
        purchaseRequests = loadedPurchaseRequests;
        loadingPurchaseRequests = false;
      });
    }
  }

  Future<void> refreshPurchaseRequests() async {
    final loadedAccounts = await ref
        .read(purchaseRequestsProvider.notifier)
        .getPurchaseRequests(apiKey, currentSC);
    if (mounted) {
      setState(() {
        purchaseRequests = loadedAccounts;
      });
    }
  }

  searchRecords(String text, pageIndex) async {
    if (text.isEmpty) {
      return;
    }
    text = text.toUpperCase();
    switch (pageIndex) {
      case 3:
        await loadPurchaseRequests();
        final searchResult = purchaseRequests.where((purchaseRequest) {
          return purchaseRequest.prnum.toUpperCase().contains(text) ||
              purchaseRequest.description.toUpperCase().contains(text) ||
              purchaseRequest.department.toUpperCase().contains(text);
        }).toList();

        setState(() {
          purchaseRequests = [...searchResult];
        });
        break;
      case 4:
        await loadPurchaseOrders();
        final searchResult = purchaseOrders.where((purchaseOrder) {
          return purchaseOrder.ponum.toUpperCase().contains(text) ||
              purchaseOrder.description.toUpperCase().contains(text) ||
              purchaseOrder.department.toUpperCase().contains(text);
        }).toList();

        setState(() {
          purchaseOrders = [...searchResult];
        });
        break;
      case 5:
        await loadWorkorders();
        final searchResult = workorders.where((workorder) {
          return workorder.wonum.toUpperCase().contains(text) ||
              workorder.description.toUpperCase().contains(text);
        }).toList();

        setState(() {
          workorders = [...searchResult];
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const int visibleItemCount = 3;
    final List<Widget> pages = [
      HomeScreen(
        navigateToPage: navigateToPage,
        getTotalRecords: getTotalRecords,
        loading: _isLoading,
        cardsContent: cardsContent,
        apiKey: apiKey,
      ),
      HomeScreen(
        navigateToPage: navigateToPage,
        getTotalRecords: getTotalRecords,
        loading: _isLoading,
        cardsContent: cardsContent,
        apiKey: apiKey,
      ),
      const AboutScreen(),
      PurchaseRequestsScreen(
        purchaseRequests: purchaseRequests,
        loading: loadingPurchaseRequests,
        refreshPurchaseRequests: refreshPurchaseRequests,
        loadPurchaseRequests: loadPurchaseRequests,
        apiKey: apiKey,
      ),
      PurchaseOrdersScreen(
        purchaseOrders: purchaseOrders,
        loading: loadingPurchaseOrders,
        loadPurchaseOrders: loadPurchaseOrders,
        refreshPurchaseOrders: refreshPurchaseOrders,
        apiKey: apiKey,
      ),
      WorkordersScreen(
        workorders: workorders,
        loading: loadingWorkorders,
        loadWorkorders: loadWorkorders,
        refreshWorkorders: refreshWorkorders,
        apiKey: apiKey,
      )
    ];

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(180),
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.tertiary,
                  Theme.of(context).colorScheme.tertiary,
                ]),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary,
                    spreadRadius: 0.1,
                    blurRadius: 1,
                    offset: const Offset(0, 0.1), // changes position of shadow
                  ),
                ],
              ),
              child: MainAppBar(
                  notifications: notifications,
                  content: MainAppBarContent(
                      itemSelected: _selectedPageIndex,
                      onSearchTextChange: searchRecords)),
            ),
          ),
          drawer: SideDrawer(
              navigateToPage: navigateToPage,
              getTotalRecords: getTotalRecords,
              apiKey: apiKey,
              currentSC: currentSC),
          body: IndexedStack(
            index: _selectedPageIndex,
            children: pages,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            width: 90,
            height: 90,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              onPressed: () {
                selectScreen(0);
              },
              child: SvgPicture.asset(
                'assets/images/tatweer_misr_logo_min.svg',
                width: 35,
                height: 35,
              ),
            ),
          ),
          bottomNavigationBar: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary,
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                    canvasColor: Theme.of(context).colorScheme.tertiary),
                child: BottomNavigationBar(
                  iconSize: 22,
                  selectedFontSize: 10,
                  unselectedFontSize: 10,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Theme.of(context).colorScheme.secondary,
                  unselectedItemColor: Theme.of(context).colorScheme.primary,
                  showUnselectedLabels: true,
                  onTap: selectScreen,
                  currentIndex: _selectedPageIndex < visibleItemCount
                      ? _selectedPageIndex
                      : 0,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined), label: 'Home'),
                    BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.info_outline), label: 'About'),
                  ],
                ),
              ))),
    );
  }
}
