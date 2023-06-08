import 'package:flutter/material.dart';

class MyBottomAppBarItem {
  MyBottomAppBarItem({required this.iconData, required this.text});
  IconData iconData;
  String text;
}

class MyBottomAppBar extends StatefulWidget {
  const MyBottomAppBar({
    required this.items,
    required this.height,
    required this.iconSize,
    required this.backgroundColor,
    required this.color,
    required this.selectedColor,
    required this.onTabSelected,
    required this.fontFamily,
    required this.fontSize,
  }) ;
  final List<MyBottomAppBarItem> items;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final ValueChanged<int> onTabSelected;
  final String fontFamily;
  final double fontSize;

  @override
  State<StatefulWidget> createState() => MyBottomAppBarState();
}

class MyBottomAppBarState extends State<MyBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildTabItem({
    required MyBottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: widget.iconSize),
                const SizedBox(height: 5,),
                Text(item.text,
                    style: TextStyle(
                        color: color,
                        fontFamily: widget.fontFamily,
                        fontSize: widget.fontSize
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


