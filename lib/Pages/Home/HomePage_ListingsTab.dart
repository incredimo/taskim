import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task.im/Helpers/Dashboard_Helper.dart';
import 'package:task.im/Style/theme.dart' as Theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task.im/services/ListingManager.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'dart:math' as math;

class HomePage_ListingsTab extends StatefulWidget {
  _HomePage_ListingsTabState createState() => _HomePage_ListingsTabState();
}

class _HomePage_ListingsTabState extends State<HomePage_ListingsTab> {
  Size deviceSize;
  var ListingsData;
  ListingManager manager;

  @override
  void initState() {
    manager = ListingManager();
    _onRefresh(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              DashboardBackground(
                showIcon: false,
              ),
              SafeArea(
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: <Widget>[
                    AppBarRegion(context),
                    SearchBarRegion(),
                    CategoryBarRegion(),
                    ListingsRegion(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  SliverFixedExtentList ListingsRegion() {
    return SliverFixedExtentList(
        itemExtent: 800.0,
        delegate: SliverChildListDelegate(<Widget>[
          // SmartRefresher(
          //     enablePullDown: true,
          //     enablePullUp: true,
          //     onRefresh: _onRefresh,
          //onOffsetChange: _onOffsetCallback,
          // child:
          new ListView.builder(
            // itemExtent: 1.0,
            itemCount: ListingsData.documents.length,
            itemBuilder: (context, index) {
              return ListingCard(context, ListingsData.documents[index].data);
            },
          )
          // )
        ]));
  }

  SliverPersistentHeader CategoryBarRegion() {
    return SliverPersistentHeader(
      pinned: false,
      delegate: _SliverAppBarDelegate(
        minHeight: 220.0,
        maxHeight: 75.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        DashboardMenuRow(
                          firstIcon: FontAwesomeIcons.solidUser,
                          firstLabel: "Carpentery",
                          firstIconCircleColor: Colors.blue,
                          secondIcon: FontAwesomeIcons.userFriends,
                          secondLabel: "Masonary",
                          secondIconCircleColor: Colors.orange,
                          thirdIcon: FontAwesomeIcons.mapMarkerAlt,
                          thirdLabel: "Delivery",
                          thirdIconCircleColor: Colors.purple,
                          fourthIcon: FontAwesomeIcons.locationArrow,
                          fourthLabel: "Electrical",
                          fourthIconCircleColor: Colors.indigo,
                        ),
                        // DashboardMenuRow(
                        //   firstIcon: FontAwesomeIcons.images,
                        //   firstLabel: "Albums",
                        //   firstIconCircleColor: Colors.red,
                        //   secondIcon: FontAwesomeIcons.solidHeart,
                        //   secondLabel: "Likes",
                        //   secondIconCircleColor: Colors.teal,
                        //   thirdIcon: FontAwesomeIcons.solidNewspaper,
                        //   thirdLabel: "Articles",
                        //   thirdIconCircleColor: Colors.lime,
                        //   fourthIcon: FontAwesomeIcons.solidCommentDots,
                        //   fourthLabel: "Reviews",
                        //   fourthIconCircleColor: Colors.amber,
                        // ),
                        DashboardMenuRow(
                          firstIcon: FontAwesomeIcons.footballBall,
                          firstLabel: "Coding",
                          firstIconCircleColor: Colors.cyan,
                          secondIcon: FontAwesomeIcons.solidStar,
                          secondLabel: "Random",
                          secondIconCircleColor: Colors.redAccent,
                          thirdIcon: FontAwesomeIcons.blogger,
                          thirdLabel: "Misc",
                          thirdIconCircleColor: Colors.pink,
                          fourthIcon: FontAwesomeIcons.wallet,
                          fourthLabel: "Charity",
                          fourthIconCircleColor: Colors.brown,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverPersistentHeader SearchBarRegion() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 75.0,
        maxHeight: 75.0,
        child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10.0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.search),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Find Tasks near me"),
                        ),
                      ),
                      Icon(Icons.my_location),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  SliverPersistentHeader AppBarRegion(BuildContext context) {
    return SliverPersistentHeader(
      pinned: false,
      delegate: _SliverAppBarDelegate(
        minHeight: 108.0,
        maxHeight: 120.0,
        child: Container(
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 18.0),
              child: new Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new IconButton(
                              icon: new Icon(
                                defaultTargetPlatform == TargetPlatform.android
                                    ? Icons.menu
                                    : Icons.menu,
                                color: Colors.white,
                              ),
                              onPressed: () =>
                                  Scaffold.of(context).openDrawer()),
                          new DashboardTitle(
                            title: "Task.im",
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new IconButton(
                            icon: new Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ListingCard(BuildContext context, data) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/explore");
          },
          child: Card(
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        data["Title"],
                        style: TextStyle(fontFamily: Theme.Fonts.quickBoldFont),
                      ),
                    ],
                  ),
                  Text(
                    data["Description"],
                    style: TextStyle(
                      fontFamily: Theme.Fonts.quickFont,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void _onRefresh(bool up) {
    manager.getListing().then((onValue) {
      setState(() {
        ListingsData = onValue;
      });
    });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
