class CryptoPairService {
  static final List<String> states = [
    'btcusd',
    'btceur',
    'btcgbp',
    'btcpax',
    'btcusdc',
    'gbpusd',
    'gbpeur',
    'eurusd',
    'xrpusd',
    'xrpeur',
    'xrpbtc',
    'xrpgbp',
    'xrppax',
    'ltcusd',
    'ltceur',
    'ltcbtc',
    'ltcgbp',
    'ethusd',
    'etheur',
    'ethbtc',
    'ethgbp',
    'ethpax',
    'ethusdc',
    'bchusd',
    'bcheur',
    'bchbtc',
    'bchgbp',
    'paxusd',
    'paxeur',
    'paxgbp',
    'xlmbtc',
    'xlmusd',
    'xlmeur',
    'xlmgbp',
    'linkusd',
    'linkeur',
    'linkgbp',
    'linkbtc',
    'linketh',
    'omgusd',
    'omgeur',
    'omggbp',
    'omgbtc',
    'usdcusd',
    'usdceur'
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(states);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
