//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Hamish Young on 29/3/2023.
//

import Foundation
import Combine

let MARKETAPI = "https://api.coingecko.com/api/v3/global"


class MarketDataManager {
    
    @Published var marketData: MarketData? = nil
    
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    private func getMarketData() {
        guard let url = URL(string: MARKETAPI) else { return }
        
        marketDataSubscription = NetworkingManager.download(from: url)
            .receive(on: DispatchQueue.main)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.completionHandler) { [weak self] globalData in
                self?.marketData = globalData.data
                self?.marketDataSubscription?.cancel()
            }
    }
}
