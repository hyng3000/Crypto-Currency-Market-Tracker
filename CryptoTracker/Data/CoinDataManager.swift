//
//  CoinDataManager.swift
//  CryptoTracker
//
//  Created by Hamish Young on 23/3/2023.
//

import Foundation
import Combine

let COINAPI =
    "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"


class CoinDataManager {
    
    @Published var allCoins: [CoinData] = []
    
    var coinsSubscription: AnyCancellable?
    
    init() {
      getCoins()
    }
    
    private func getCoins() {
        guard let url = URL(string: COINAPI) else { return }
        
        coinsSubscription = NetworkingManager.download(from: url)
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinData].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.completionHandler) { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinsSubscription?.cancel()
            }
    }
}
