import 'package:crypto_coins_news_app/controller/povider.dart';
import 'package:crypto_coins_news_app/controller/geting_data.dart';
import 'package:crypto_coins_news_app/controller/setting_page.dart';
import 'package:crypto_coins_news_app/view/list_tile.dart';
import 'package:crypto_coins_news_app/controller/search_bar.dart';
import 'package:crypto_coins_news_app/view/offline_page.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:crypto_coins_news_app/model/model.dart';
import 'package:flutter/material.dart';

int maxFailedLoadAttempts = 3;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String search = 'bitcoin';

  bool select = false;
  InterstitialAd _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-6910872176334334/4017947119",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd.show();
    _interstitialAd = null;
  }

  @override
  void didChangeDependencies() {
    WidgetsFlutterBinding.ensureInitialized();
    _createInterstitialAd();

    myBanner.load();
    GetData().getChart();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _interstitialAd.dispose();
    super.dispose();
  }

  final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );

  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-6910872176334334/5498549740',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModes>(builder: (context, notify, child) {
      var isconnected = Provider.of<DataConnectionStatus>(context);
      if (isconnected == DataConnectionStatus.connected) {
        return SafeArea(
            child: Scaffold(
                bottomNavigationBar: Container(
                  width: myBanner.size.width.toDouble(),
                  height: myBanner.size.height.toDouble(),
                  child: AdWidget(ad: myBanner),
                ),
                appBar: AppBar(
                  elevation: 0.0,
                  title: Text('Crypto Coin Market News'),
                  centerTitle: false,
                  actions: [
                    IconButton(
                        onPressed: () {
                          showSearch(context: context, delegate: DataSearch());
                        },
                        icon: Icon(Icons.search)),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.cog,
                        size: 20.0,
                      ),
                      onPressed: () => Get.to(SettingsPage()),
                    ),
                  ],
                ),
                body: Center(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: StreamBuilder<List<Model>>(
                      stream: Stream.periodic(Duration(seconds: 1))
                          .asyncMap((i) => GetData().getData()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Model> data = snapshot.data;
                          return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListOfTile(
                                  isSparck: true,
                                  sparkLink: data[index].sparckLink,
                                  title: data[index].id,
                                  price: data[index].price,
                                  image: data[index].image,
                                  capital: data[index].capital,
                                );
                              });
                        } else if (snapshot.hasError) {
                          print('${snapshot.error}');
                        }
                        _showInterstitialAd();
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                )));
      }
      return Scaffold(body: Offline());
    });
  }
}
