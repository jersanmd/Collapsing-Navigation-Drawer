import 'package:flutter/material.dart';
import 'package:collapsible_sidebar/model/navigation_model.dart';
import 'collapsing_list_tile.dart';
import 'package:collapsible_sidebar/theme.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  _CollapsingNavigationDrawerState createState() =>
      _CollapsingNavigationDrawerState();
}

class _CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 250;
  double minWidth = 70;

  bool isCollapsed = false;
  int currentSelectedIndex = 0;

  AnimationController _animationController;
  Animation<double> widthAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, widget) => getWidget(context, widget));
  }

  Widget getWidget(context, widget) {
    return Material(
      elevation: 8,
          child: Container(
        width: widthAnimation.value,
        color: drawerBackgroundColor,
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            CollapsingListTile(
              title: "Jersan Balago",
              icon: Icons.person,
              animationController: _animationController,
            ),
            Divider(color: Colors.grey, height: 40.0),
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, counter) {
                    return Divider(color: Colors.grey, height: 40);
                  },
                  itemBuilder: (context, counter) {
                    return CollapsingListTile(
                        onTap: () {
                          setState(() {
                            currentSelectedIndex = counter;
                          });
                        },
                        isSelected: currentSelectedIndex == counter,
                        title: navigationItems[counter].title,
                        icon: navigationItems[counter].icon,
                        animationController: _animationController);
                  },
                  itemCount: navigationItems.length),
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                    isCollapsed
                        ? _animationController.forward()
                        : _animationController.reverse();
                  });
                },
                child: AnimatedIcon(
                  icon: AnimatedIcons.close_menu,
                  progress: _animationController,
                  color: Colors.white,
                  size: 50,
                )),
            SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
