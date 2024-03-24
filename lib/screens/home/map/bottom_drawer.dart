import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';

class MapBottomDrawer extends StatefulWidget {
  final String smokingAreaId;
  const MapBottomDrawer({super.key, required this.smokingAreaId});

  @override
  State<MapBottomDrawer> createState() => _MapBottomDrawerState();
}

class _MapBottomDrawerState extends State<MapBottomDrawer> {
  String get _smokingAreaId => widget.smokingAreaId;

  @override
  Widget build(BuildContext context) {
    return _buildBottomDrawer(context);
  }

  Widget _buildBottomDrawer(BuildContext context) {
    return BottomDrawer(
      header: _buildBottomDrawerHead(context),
      body: _buildBottomDrawerBody(context),
      headerHeight: _headerHeight,
      drawerHeight: _bodyHeight,
      color: Colors.lightBlue,
      controller: _controller,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 60,
          spreadRadius: 5,
          offset: const Offset(2, -6), // changes position of shadow
        ),
      ],
    );
  }

  Widget _buildBottomDrawerHead(BuildContext context) {
    return SizedBox(
      height: _headerHeight,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text("흡연구역 $_smokingAreaId"),
          ),
          const Spacer(),
          // const Divider(
          //   height: 1.0,
          //   color: Colors.grey,
          // ),
        ],
      ),
    );
  }

  Widget _buildBottomDrawerBody(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: _bodyHeight,
      child: SingleChildScrollView(
          child: Column(
        children: _buildButtons(_smokingAreaId, 1, 25),
      )),
    );
  }

  List<Widget> _buildButtons(String prefix, int start, int end) {
    List<Widget> buttons = [];
    for (int i = start; i <= end; i++) {
      buttons.add(TextButton(
        child: Text(
          '$prefix Button $i',
          style: const TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          ),
        ),
        onPressed: () {
          setState(() {
            _button = '$prefix Button $i';
          });
        },
      ));
    }
    return buttons;
  }

  String _button = 'None';
  final double _headerHeight = 60.0;
  final double _bodyHeight = 300.0;
  final BottomDrawerController _controller = BottomDrawerController();
}
