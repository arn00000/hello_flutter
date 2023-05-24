import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/data/repository/user_repo_impl.dart';
import 'package:hello_flutter/service/auth_service.dart';
import 'package:hello_flutter/ui/home_tabs/tab1.dart';
import 'package:hello_flutter/ui/home_tabs/tab2.dart';
import 'package:hello_flutter/ui/home_tabs/tab3.dart';
import 'package:hello_flutter/ui/home_tabs/tab4.dart';
import 'package:hello_flutter/ui/home_tabs/tab5.dart';

import '../data/model/user.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final repo = UserRepoImpl();
  late User _user;

  Widget _tabBarItem(String s, IconData icon) {
    return SizedBox(
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon), Text(s)],
      ),
    );
  }

  late final _tabController = TabController(length: 5, vsync: this);

  void _toTab(BuildContext context) {
    _tabController.index = 2;
    Navigator.of(context).pop();
  }

  void _navigateToBuy(BuildContext context) {
    // context.push("/design");
    DefaultTabController.of(context).animateTo(0);
  }

  void _navigateToCounter(BuildContext context) {
    Navigator.of(context).pop();
    context.push("/counter");
  }

  void _navigateToCanvas(BuildContext context) {
    Navigator.of(context).pop();
    context.push("/canvas");
  }

  void _logout(BuildContext context) {
    AuthService.deAuthenticate();
    Navigator.of(context).pop();
    context.go("/login");
  }


  @override
  void initState() {
    super.initState();
    _initializeUserString();
  }

  Future<void> _initializeUserString() async {
    final user = await AuthService.getUser();
    final temp = await repo.getUserByEmail(user!.email);
    _user = temp!;
    setState(() {});
    debugPrint(_user.image.toString());
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.blue),
          title: const Text(
            "Home",
            style: TextStyle(color: Colors.blue),
          ),
          // bottom: const TabBar(
          //   tabs:[
          //     Tab(icon: Icon(Icons.home)),
          //     Tab(icon: Icon(Icons.settings)),
          //     Tab(icon: Icon(Icons.person))
          //   ],
          // ),
        ),
        body: TabBarView(
            controller: _tabController,
            children: const [FirstTab(), SecondTab(), ThirdTab(), FourthTab(), FifthTab()]),
        bottomNavigationBar: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          tabs: [
            _tabBarItem("Home", Icons.home),
            _tabBarItem("Setting", Icons.settings),
            _tabBarItem("Profile", Icons.person),
            _tabBarItem("Profile", Icons.production_quantity_limits),
            _tabBarItem("Text", Icons.update),
          ],
        ),
        drawer: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.8,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue.shade200),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _toTab(context);
                      },
                      child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              image: const DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      'assets/images/khayrul.jpeg')))),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Expanded(
                    flex: 1,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            onTap: () {
                              _navigateToBuy(context);
                            },
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Buy now",
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Icon(
                                      Icons.shopping_cart,
                                      color: Colors.blue.shade700,
                                      size: 28,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              _navigateToCounter(context);
                            },
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Counter",
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Icon(
                                      Icons.plus_one,
                                      color: Colors.blue.shade700,
                                      size: 28,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              _navigateToCanvas(context);
                            },
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Canvas",
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Icon(
                                      Icons.animation,
                                      color: Colors.blue.shade700,
                                      size: 28,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              _logout(context);
                            },
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Logout",
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Icon(
                                      Icons.exit_to_app_sharp,
                                      color: Colors.blue.shade700,
                                      size: 28,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class CustomText extends StatelessWidget {
//   const CustomText({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const Text(
//       "Hello Flutter",
//       textDirection: TextDirection.ltr,
//       style: TextStyle(
//           fontSize: 20.5, fontWeight: FontWeight.bold, color: Colors.white),
//     );
//   }
// }
