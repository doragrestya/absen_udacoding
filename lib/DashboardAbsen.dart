import 'package:absent_udacoding/ui_page/SearchPage.dart';
import 'package:flutter/material.dart';
import 'ui_page/checkin/CheckIn.dart' as tabcheckin;
import 'ui_page/checkout/CheckOut.dart' as tabcheckout;

class DashboardAbsen extends StatefulWidget {
  List list;
  DashboardAbsen({this.list});
  @override
  _DashboardAbsenState createState() => _DashboardAbsenState();
}

class _DashboardAbsenState extends State<DashboardAbsen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: Icon(
                Icons.search,
                color: Colors.black,
              ),
              title: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Users',
                  ),
                  onChanged: (text) {
                    text = text.toLowerCase();
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>SearchPage()));
                    });
                  }),
            ),
          ),
        ),
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(
              text: 'Check In',
            ),
            Tab(
              text: 'Check Out',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          tabcheckin.CheckIn(controller),
          tabcheckout.CheckOut(),
        ],
      ),
    );
  }
}
