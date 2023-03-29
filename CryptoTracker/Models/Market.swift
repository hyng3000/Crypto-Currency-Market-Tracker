//
//  MarketModel.swift
//  CryptoTracker
//
//  Created by Hamish Young on 28/3/2023.
//

import Foundation

// API / JSON Data:
/**

https://api.coingecko.com/api/v3/global


{
  "data": {
    "active_cryptocurrencies": 11082,
    "upcoming_icos": 0,
    "ongoing_icos": 49,
    "ended_icos": 3376,
    "markets": 701,
    "total_market_cap": {
      "btc": 43724968.6682974,
      "eth": 671847173.0498762,
      "ltc": 13384782306.603485,
      "bch": 9849106885.71272,
      "bnb": 3809715122.135191,
      "eos": 1070508083942.9353,
      "xrp": 2307839525903.453,
      "xlm": 12227067442532.594,
      "link": 171511721148.3437,
      "dot": 196624280065.36002,
      "yfi": 140786186.60579947,
      "usd": 1193306525782.8835,
      "aed": 4382895538547.9614,
      "ars": 247970647356166.38,
      "aud": 1779660360050.2925,
      "bdt": 128328288793665.7,
      "bhd": 449911166109.39264,
      "bmd": 1193306525782.8835,
      "brl": 6164084524257.791,
      "cad": 1622227430103.757,
      "chf": 1098433883757.0394,
      "clp": 950856946149636.5,
      "cny": 8203147050189.29,
      "czk": 26033592823763.39,
      "dkk": 8202275936425.47,
      "eur": 1100976819963.485,
      "gbp": 967831257736.2087,
      "hkd": 9367277231416.773,
      "huf": 419549117584095.9,
      "idr": 17978306929349936,
      "ils": 4229197658027.1157,
      "inr": 98047249075176.22,
      "jpy": 156343441088496.12,
      "krw": 1547887903682860.5,
      "kwd": 365509788847.29706,
      "lkr": 387283779756062.8,
      "mmk": 2502292560873408,
      "mxn": 21762569772007.617,
      "myr": 5262481778702.531,
      "ngn": 548792063896708.9,
      "nok": 12366881105518.473,
      "nzd": 1908984954782.0125,
      "php": 64789391670694.98,
      "pkr": 337976877972279.1,
      "pln": 5151852717310.25,
      "rub": 91371096434494.12,
      "sar": 4481544995727.909,
      "sek": 12359845370242.445,
      "sgd": 1584746865435.4438,
      "thb": 40855445545177.11,
      "try": 22821903774140.844,
      "twd": 36228786122768.32,
      "uah": 44005907230268.2,
      "vef": 119485782426.64009,
      "vnd": 28036736823268820,
      "zar": 21654909657251.453,
      "xdr": 888155374316.2119,
      "xag": 51090989311.04488,
      "xau": 604899010.9846009,
      "bits": 43724968668297.41,
      "sats": 4372496866829740.5
    },
    "total_volume": {
      "btc": 1780758.2010619487,
      "eth": 27361880.401673015,
      "ltc": 545113274.8139516,
      "bch": 401118134.4215604,
      "bnb": 155155776.07196334,
      "eos": 43597882579.31128,
      "xrp": 93989870951.40486,
      "xlm": 497963778737.1179,
      "link": 6985045691.630356,
      "dot": 8007788454.018012,
      "yfi": 5733706.94205411,
      "usd": 48599014404.99663,
      "aed": 178499320008.11246,
      "ars": 10098938372077.012,
      "aud": 72479063514.16539,
      "bdt": 5226342285826.61,
      "bhd": 18323237802.101383,
      "bmd": 48599014404.99663,
      "brl": 251040638859.73102,
      "cad": 66067395543.714195,
      "chf": 44735198363.74171,
      "clp": 38724928947070.13,
      "cny": 334084204724.26886,
      "czk": 1060253107914.4471,
      "dkk": 334048727443.75323,
      "eur": 44838762863.43885,
      "gbp": 39416230633.172554,
      "hkd": 381494973227.0629,
      "huf": 17086702509815.07,
      "idr": 732190747774305.6,
      "ils": 172239766952.74847,
      "inr": 3993106186232.112,
      "jpy": 6367297070299.445,
      "krw": 63039818272216.8,
      "kwd": 14885878112.25046,
      "lkr": 15772653198924.129,
      "mmk": 101909232526504.11,
      "mxn": 886309945506.8049,
      "myr": 214321653526.0357,
      "ngn": 22350295454192.965,
      "nok": 503657878345.7732,
      "nzd": 77745981700.3069,
      "php": 2638635179698.9707,
      "pkr": 13764563258677.002,
      "pln": 209816136098.57724,
      "rub": 3721210884107.9546,
      "sar": 182516951929.9592,
      "sek": 503371338556.8409,
      "sgd": 64540949100.267715,
      "thb": 1663893009610.4043,
      "try": 929452748564.5521,
      "twd": 1475466077335.6965,
      "uah": 1792199802130.1912,
      "vef": 4866219312.372311,
      "vnd": 1141833843445394.5,
      "zar": 881925342427.1848,
      "xdr": 36171323040.36536,
      "xag": 2080749306.1047451,
      "xau": 24635326.392036818,
      "bits": 1780758201061.9487,
      "sats": 178075820106194.88
    },
    "market_cap_percentage": {
      "btc": 44.21032327466439,
      "eth": 17.933869123590103,
      "usdt": 6.671952651682914,
      "bnb": 4.144277476473995,
      "usdc": 2.7943980532489903,
      "xrp": 2.2442025784033115,
      "ada": 1.0852937700746437,
      "steth": 0.8740648124387681,
      "doge": 0.8615169676728031,
      "matic": 0.8278193777632751
    },
    "market_cap_change_percentage_24h_usd": 1.748319478381625,
    "updated_at": 1680047022
  }
}

*/


struct GlobalData: Codable {
    let data: MarketData?
}


struct MarketData: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "aud" }) {
            return "$" + "\(item.value.formattedWithAbbreviation())"
        } else {
            return ""
        }
    }
    
    var tradingVolume: String {
        if let item = totalVolume.first(where: { $0.key == "aud" }) {
             return "$" + "\(item.value.formattedWithAbbreviation())"
        } else {
            return ""
        }
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}) {
            return "$" + "\(item.value.formattedWithAbbreviation())"
        } else {
            return ""
        }
    }
    
    var ethDominance: String {
        if let item = marketCapPercentage.first(where: {$0.key == "eth"}) {
            return "$" + "\(item.value.formattedWithAbbreviation())"
        } else {
            return ""
        }
    }
}
