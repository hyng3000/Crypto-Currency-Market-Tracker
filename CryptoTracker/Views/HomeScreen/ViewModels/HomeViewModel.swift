//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Hamish Young on 22/3/2023.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {

    private let coinDataService = CoinDataManager()
    private let marketDataSerive = MarketDataManager()
    
    private var cancellables =  Set<AnyCancellable>()
    
    @Published var allCoins: [CoinData] = []
    
    @Published var portfolioCoins: [CoinData] = []
    
    @Published var searchtext: String = ""
    
    @Published var analytics: [AnalyticsModel] = []

    
    
    init() {
    
        addCoinsSubscriberWithFilter()
        addMarketDataSubscription()
        
    }
    
    func addCoinsSubscriberWithFilter() {
        $searchtext
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoinsByName)
            .sink(receiveValue: {[weak self] (coins) in
                self?.allCoins = coins
            })
            .store(in: &cancellables)
    }
    
    func addMarketDataSubscription() {
        marketDataSerive.$marketData
            .map(MarketDataMapped)
            .sink { [weak self] (data) in
                self?.analytics = data
            }
            .store(in: &cancellables)
    }
    
}


// Helper Methods

extension HomeViewModel {
    
    func filterCoinsByName(search: any StringProtocol, coins: [CoinData]) -> [CoinData] {
    
            guard !search.isEmpty else { return coins }
            let formattedSearch = search.lowercased()
            
            return coins.filter { coin -> Bool in
                    coin.name.contains(formattedSearch) ||
                    coin.id.contains(formattedSearch) ||
                    coin.symbol.contains(formattedSearch)
        }
    }
    
    func MarketDataMapped(marketData: MarketData?) -> [AnalyticsModel] {
            guard let data = marketData else { return self.analytics }
            
            let marketCap = AnalyticsModel(title: "Market Cap", value: data.marketCap, percentagechange: data.marketCapChangePercentage24HUsd)
            let tradingVolume = AnalyticsModel(title: "24Hr Volume", value: data.tradingVolume)
            let btcMarketShare = AnalyticsModel(title: "BTC Market Share", value: data.btcDominance, percentagechange: data.marketCapChangePercentage24HUsd)
            let portfolio = AnalyticsModel(title: "Portfolio", value: "0.0")
            
            return [marketCap, tradingVolume, btcMarketShare]
    }
}
