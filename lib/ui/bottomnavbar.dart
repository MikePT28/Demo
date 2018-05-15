import 'package:flutter/material.dart';

import 'bottomnavigation/bottomnavigationiconitem.dart';

abstract class BottomNavBarDelegate {

  redraw();

}

class BottomNavBar extends StatefulWidget {

  final List<State> children;
  final BottomNavBarDelegate delegate;

  final state = _BottomNavBar();

  BottomNavBar(this.children, this.delegate);

  Widget buildTransitionsStack() { return state.buildTransitionsStack(); }

  @override
  State<StatefulWidget> createState() => state;
}

class _BottomNavBar extends State<BottomNavBar> with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<NavigationIconView> _navigationViews;
  BottomNavigationBarType _type = BottomNavigationBarType.fixed;


  _BottomNavBar() {
    _navigationViews = [
      NavigationIconView(
          icon: Icon(Icons.add),
          color: Colors.red,
          title: "Some",
          vsync: this
      ),
      NavigationIconView(
          icon: Icon(Icons.add),
          color: Colors.red,
          title: "Some2",
          vsync: this
      )
    ];

    for (NavigationIconView view in _navigationViews) {
      view.controller.addListener(_rebuild);
    }

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews) {
      view.controller.dispose();
    }
    super.dispose();
  }


  void _rebuild() {
    setState(() {

    });
  }

  Widget buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    if (_navigationViews == null) return null;

    var colors = [Colors.red, Colors.black];

    for (NavigationIconView view in _navigationViews) {
      var transition = view.transition(_type, context);

      transitions.add(transition);
    }

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
  }


  @override
  Widget build(BuildContext context) {
    return
      BottomNavigationBar(
        items: _navigationViews.map((item) => item.item).toList(),
        currentIndex: _currentIndex,
        type: _type,
        onTap: (index) {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
          widget.delegate.redraw();
        },
      );
  }


}