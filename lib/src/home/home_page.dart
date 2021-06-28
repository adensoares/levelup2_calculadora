import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:levelup_2_calculadora/src/home/home_controller.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeController _homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade100,
                              blurRadius: 1.0,
                              offset: Offset(0.0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              _homeController.showEqual ? "=" : "",
                              style: TextStyle(
                                color: Color(0xff51C9DC),
                                fontSize: 55.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 16.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade100,
                              blurRadius: 1.0,
                              offset: Offset(0.0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              _homeController.displayValue,
                              style: TextStyle(
                                color: Color(0xff1A1A28),
                                fontSize: 55.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      _homeController.displayHistory,
                      style: TextStyle(
                        color: Color(0xff1A1A28),
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 400.0,
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      itemCount: 19,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                        onTap: () {
                          setState(() {
                            _homeController.tapButton(index);
                          });
                        },
                        child: new Container(
                            decoration: BoxDecoration(
                              color: _homeController.isOperator(index)
                                  ? Color(0xff51C9DC)
                                  : Color(0xffF2F8FD),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: new Center(
                              child: new Text(
                                _homeController.options[index],
                                style: TextStyle(
                                    color: _homeController.isOperator(index)
                                        ? Colors.white
                                        : Color(0xff1A1A28),
                                    fontSize: 34.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      staggeredTileBuilder: (int index) {
                        if (index == 15) {
                          return StaggeredTile.count(1, 2);
                        } else {
                          return StaggeredTile.count(1, 1);
                        }
                      },
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
