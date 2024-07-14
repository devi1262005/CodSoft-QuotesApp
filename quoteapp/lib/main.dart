import 'package:flutter/material.dart';
import 'dart:async';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> quotes = [
    '\"Success is not final, failure is not fatal, It is the courage to continue that counts\" - Winston Churchill',
    '\"Life is what happens when you are busy making other plans\" - John Lennon',
    '\"Do not go where the path may lead, go instead where there is no path and leave a trail\" - Ralph Waldo Emerson',
    '\"The only limit to our realization of tomorrow is our doubts of today\" - Franklin D. Roosevelt',
    '\"The best way to predict the future is to invent it\" - Alan Kay'
  ];

  int currentQuoteIndex = 0;
  Set<int> favoriteQuotes = {};
  Timer? _timer;
  bool showRefreshNotification = true;

  @override
  void initState() {
    super.initState();
    _startQuoteTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startQuoteTimer() {
    _timer = Timer.periodic(Duration(hours: 24), (timer) {
      setState(() {
        currentQuoteIndex = (currentQuoteIndex + 1) % quotes.length;
      });
    });
  }

  void _toggleFavorite(int index) {
    setState(() {
      if (favoriteQuotes.contains(index)) {
        favoriteQuotes.remove(index);
      } else {
        favoriteQuotes.add(index);
      }
    });
  }

  void _dismissNotification() {
    setState(() {
      showRefreshNotification = false;
    });
  }

  void _showFavorites() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: favoriteQuotes
                .map((index) => ListTile(
              title: Text(quotes[index]),
            ))
                .toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (scaffoldKey.currentState!.isDrawerOpen) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        drawer: Drawer(
          elevation: 16,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Favorites',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
              ...favoriteQuotes.map((index) => ListTile(
                title: Text(quotes[index]),
              )),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Align(
            alignment: AlignmentDirectional(0, -1),
            child: Text(
              'Quote Of The Day!',
              style: TextStyle(
                fontFamily: 'Outfit',
                color: Colors.white,
                fontSize: 22,
                letterSpacing: 0,
              ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              if (showRefreshNotification)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.yellow,
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Refreshing every 24 hours'),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: _dismissNotification,
                        )
                      ],
                    ),
                  ),
                ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Container(
                    width: 487,
                    height: 181,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          quotes[currentQuoteIndex],
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Colors.black,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        IconButton(
                          icon: Icon(
                            favoriteQuotes.contains(currentQuoteIndex)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: favoriteQuotes.contains(currentQuoteIndex)
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () =>
                              _toggleFavorite(currentQuoteIndex),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
