import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(home: HomePageWidget()));
}

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
    '\"The best way to predict the future is to invent it\" - Alan Kay',
    '\"In the end, it\'s not the years in your life that count. It\'s the life in your years.\" - Abraham Lincoln',
    '\"Believe you can and you\'re halfway there.\" - Theodore Roosevelt',
    '\"Life is either a daring adventure or nothing at all.\" - Helen Keller',
    '\"The only way to do great work is to love what you do.\" - Steve Jobs',
    '\"We may encounter many defeats but we must not be defeated.\" - Maya Angelou',
    '\"Life is 10% what happens to us and 90% how we react to it.\" - Charles R. Swindoll',
    '\"It is never too late to be what you might have been.\" - George Eliot',
    '\"The greatest glory in living lies not in never falling, but in rising every time we fall.\" - Nelson Mandela',
    '\"Your time is limited, so don\'t waste it living someone else\'s life.\" - Steve Jobs',
    '\"I have learned over the years that when one\'s mind is made up, this diminishes fear.\" - Rosa Parks',
    '\"Life is really simple, but we insist on making it complicated.\" - Confucius',
    '\"It does not matter how slowly you go as long as you do not stop.\" - Confucius',
    '\"Success usually comes to those who are too busy to be looking for it.\" - Henry David Thoreau',
    '\"Life isn\'t about waiting for the storm to pass, it\'s about learning to dance in the rain.\" - Vivian Greene',
    '\"The purpose of our lives is to be happy.\" - Dalai Lama',
    '\"Life is like riding a bicycle. To keep your balance, you must keep moving.\" - Albert Einstein',
    '\"You only live once, but if you do it right, once is enough.\" - Mae West',
    '\"The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart.\" - Helen Keller',
    '\"I have not failed. I\'ve just found 10,000 ways that won\'t work.\" - Thomas A. Edison',
    '\"In the end, it\'s not the years in your life that count. It\'s the life in your years.\" - Abraham Lincoln',
    '\"Believe you can and you\'re halfway there.\" - Theodore Roosevelt',
    '\"Life is either a daring adventure or nothing at all.\" - Helen Keller',
    '\"The only way to do great work is to love what you do.\" - Steve Jobs',
    '\"We may encounter many defeats but we must not be defeated.\" - Maya Angelou',
    '\"Life is 10% what happens to us and 90% how we react to it.\" - Charles R. Swindoll',
    '\"It is never too late to be what you might have been.\" - George Eliot',
    '\"The greatest glory in living lies not in never falling, but in rising every time we fall.\" - Nelson Mandela',
    '\"Your time is limited, so don\'t waste it living someone else\'s life.\" - Steve Jobs',
    '\"I have learned over the years that when one\'s mind is made up, this diminishes fear.\" - Rosa Parks',
    '\"Life is really simple, but we insist on making it complicated.\" - Confucius',
    '\"It does not matter how slowly you go as long as you do not stop.\" - Confucius',
    '\"Success usually comes to those who are too busy to be looking for it.\" - Henry David Thoreau',
    '\"Life isn\'t about waiting for the storm to pass, it\'s about learning to dance in the rain.\" - Vivian Greene',
    '\"The purpose of our lives is to be happy.\" - Dalai Lama',
    '\"Life is like riding a bicycle. To keep your balance, you must keep moving.\" - Albert Einstein',
    '\"You only live once, but if you do it right, once is enough.\" - Mae West',
    '\"The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart.\" - Helen Keller',
    '\"I have not failed. I\'ve just found 10,000 ways that won\'t work.\" - Thomas A. Edison',
    '\"Life is what happens when you are busy making other plans\" - John Lennon',
    '\"Do not go where the path may lead, go instead where there is no path and leave a trail\" - Ralph Waldo Emerson',
    '\"The only limit to our realization of tomorrow is our doubts of today\" - Franklin D. Roosevelt',
    '\"The best way to predict the future is to invent it\" - Alan Kay',
    '\"Your time is limited, don\'t waste it living someone else\'s life\" - Steve Jobs',
    '\"Whether you think you can or you think you can\'t, you\'re right\" - Henry Ford',
    '\"The only way to do great work is to love what you do\" - Steve Jobs',
    '\"You miss 100% of the shots you don\'t take\" - Wayne Gretzky',
    '\"I have not failed. I\'ve just found 10,000 ways that won\'t work\" - Thomas Edison',
    '\"It\'s not whether you get knocked down, it\'s whether you get up\" - Vince Lombardi',
    '\"If you set your goals ridiculously high and it\'s a failure, you will fail above everyone else\'s success\" - James Cameron',
    '\"Life is 10% what happens to us and 90% how we react to it\" - Charles R. Swindoll',
    '\"The best revenge is massive success\" - Frank Sinatra',
    '\"Believe you can and you\'re halfway there\" - Theodore Roosevelt',
    '\"The only limit to our realization of tomorrow is our doubts of today\" - Franklin D. Roosevelt',
    '\"Your time is limited, don\'t waste it living someone else\'s life\" - Steve Jobs',
    '\"Don\'t watch the clock; do what it does. Keep going\" - Sam Levenson',
    '\"You can\'t cross the sea merely by standing and staring at the water\" - Rabindranath Tagore',
    '\"Either you run the day or the day runs you\" - Jim Rohn',
    '\"Success usually comes to those who are too busy to be looking for it\" - Henry David Thoreau',
    '\"Opportunities don\'t happen. You create them\" - Chris Grosser',
    '\"Don\'t be afraid to give up the good to go for the great\" - John D. Rockefeller',
    '\"I find that the harder I work, the more luck I seem to have\" - Thomas Jefferson',
    '\"Success is not in what you have, but who you are\" - Bo Bennett',
    '\"The way to get started is to quit talking and begin doing\" - Walt Disney',
    '\"Don\'t let yesterday take up too much of today\" - Will Rogers',
    '\"You learn more from failure than from success. Don\'t let it stop you. Failure builds character\" - Unknown',
    '\"It\'s not whether you get knocked down, it\'s whether you get up\" - Vince Lombardi',
    '\"If you are working on something that you really care about, you don\'t have to be pushed. The vision pulls you\" - Steve Jobs',
    '\"People who are crazy enough to think they can change the world, are the ones who do\" - Rob Siltanen',
    '\"Failure will never overtake me if my determination to succeed is strong enough\" - Og Mandino',
    '\"Entrepreneurs are great at dealing with uncertainty and also very good at minimizing risk. That\'s the classic entrepreneur\" - Mohnish Pabrai',
    '\"We may encounter many defeats but we must not be defeated\" - Maya Angelou',
    '\"Knowing is not enough; we must apply. Wishing is not enough; we must do\" - Johann Wolfgang Von Goethe',
    '\"Imagine your life is perfect in every respect; what would it look like?\" - Brian Tracy',
    '\"We generate fears while we sit. We overcome them by action\" - Dr. Henry Link',
    '\"Whether you think you can or think you can\'t, you\'re right\" - Henry Ford',
    '\"Security is mostly a superstition. Life is either a daring adventure or nothing\" - Helen Keller',
    '\"The man who has confidence in himself gains the confidence of others\" - Hasidic Proverb',
    '\"The only limit to our realization of tomorrow is our doubts of today\" - Franklin D. Roosevelt',
    '\"The best way to predict the future is to invent it\" - Alan Kay',
    '\"Life is what happens when you are busy making other plans\" - John Lennon',
    '\"If you are not willing to risk the usual, you will have to settle for the ordinary\" - Jim Rohn',
    '\"Do one thing every day that scares you\" - Eleanor Roosevelt',
    '\"Go confidently in the direction of your dreams. Live the life you have imagined\" - Henry David Thoreau',
    '\"Believe you can and you\'re halfway there\" - Theodore Roosevelt',
    '\"Success is not final, failure is not fatal: It is the courage to continue that counts\" - Winston Churchill'
  ];




  ValueNotifier<Set<int>> favoriteQuotes = ValueNotifier<Set<int>>({});
  late int currentQuoteIndex;
  bool isRefreshing = false; // Track whether refresh is in progress

  @override
  void initState() {
    super.initState();
    currentQuoteIndex = 0;
    _loadFavorites(); // Load favorite quotes from shared preferences
    _startQuoteTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Timer? _timer;

  void _startQuoteTimer() {
    _timer = Timer.periodic(Duration(hours: 24), (timer) {
      _refreshQuote();
    });
  }

  void _refreshQuote() {
    setState(() {
      currentQuoteIndex = (currentQuoteIndex + 1) % quotes.length;
    });
  }

  Future<void> _forceRefresh() async {
    setState(() {
      currentQuoteIndex = Random().nextInt(quotes.length);
      isRefreshing = true; // Set refreshing state to true
    });

    await Future.delayed(Duration(seconds: 2)); // Simulating a refresh delay

    setState(() {
      isRefreshing = false; // Set refreshing state to false
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Quotes refreshed!'),
      duration: Duration(seconds: 2),
    ));
  }

  void _toggleFavorite(int index) async {
    setState(() {
      if (favoriteQuotes.value.contains(index)) {
        favoriteQuotes.value.remove(index);
      } else {
        favoriteQuotes.value.add(index);
      }
    });
    // Save favorite quotes to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteQuotes', favoriteQuotes.value.map((e) => e.toString()).toList());
    favoriteQuotes.notifyListeners(); // Notify listeners about the change
  }

  Future<void> _shareQuote(String quote) async {
    try {
      await FlutterShare.share(
        title: 'Share Quote',
        text: quote,
      );
    } catch (e) {
      print('Error sharing quote: $e');
    }
  }

  void _copyToClipboard(String quote) {
    Clipboard.setData(ClipboardData(text: quote));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Quote copied to clipboard'),
      duration: Duration(seconds: 2),
    ));
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favs = prefs.getStringList('favoriteQuotes');
    if (favs != null) {
      setState(() {
        favoriteQuotes.value = favs.map((e) => int.parse(e)).toSet();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.menu, size: 24),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              _forceRefresh();
            },
          ),
        ],
        title: Text(
          'Quote Of The Day!',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: Colors.white,
            fontSize: 22,
            letterSpacing: 0,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 60,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Favorites'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteQuotesPage(favoriteQuotes: favoriteQuotes, quotes: quotes)));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.refresh),
              title: Text('Force Refresh'),
              onTap: () {
                _forceRefresh();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Refreshes every 24 hours!'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: true,
        child: ValueListenableBuilder<Set<int>>(
          valueListenable: favoriteQuotes,
          builder: (context, value, child) {
            return RefreshIndicator(
              onRefresh: _forceRefresh, // Call _forceRefresh() when refreshing
              child: ListView.builder(
                itemCount: 5, // Display 5 quotes
                itemBuilder: (context, index) {
                  int actualIndex = (currentQuoteIndex + index) % quotes.length;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              quotes[actualIndex],
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: Colors.black,
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: value.contains(actualIndex)
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                onPressed: () => _toggleFavorite(actualIndex),
                              ),
                              IconButton(
                                icon: Icon(Icons.share),
                                onPressed: () {
                                  _shareQuote(quotes[actualIndex]);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.content_copy),
                                onPressed: () {
                                  _copyToClipboard(quotes[actualIndex]);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class FavoriteQuotesPage extends StatefulWidget {
  final ValueNotifier<Set<int>> favoriteQuotes;
  final List<String> quotes;

  FavoriteQuotesPage({Key? key, required this.favoriteQuotes, required this.quotes}) : super(key: key);

  @override
  _FavoriteQuotesPageState createState() => _FavoriteQuotesPageState();
}

class _FavoriteQuotesPageState extends State<FavoriteQuotesPage> {
  @override
  void initState() {
    super.initState();
  }

  void _removeFromFavorites(int quoteIndex) async {
    setState(() {
      widget.favoriteQuotes.value.remove(quoteIndex);
    });

    // Save updated favorite quotes to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteQuotes', widget.favoriteQuotes.value.map((e) => e.toString()).toList());

    widget.favoriteQuotes.notifyListeners(); // Notify listeners about the change

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Quote removed from favorites'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  bool _isFavorite(int quoteIndex) {
    return widget.favoriteQuotes.value.contains(quoteIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Quotes'),
      ),
      body: ValueListenableBuilder<Set<int>>(
        valueListenable: widget.favoriteQuotes,
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: widget.quotes.length,
            itemBuilder: (context, index) {
              if (_isFavorite(index)) {
                return ListTile(
                  title: Text(widget.quotes[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _removeFromFavorites(index);
                    },
                  ),
                );
              } else {
                return SizedBox.shrink(); // Return an empty widget if not a favorite
              }
            },
          );
        },
      ),
    );
  }
}
