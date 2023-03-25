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
    private var cancellables =  Set<AnyCancellable>()
    

    @Published var allCoins: [CoinData] = []
    @Published var portfolioCoins: [CoinData] = []
    
    init() {
        addSubscriber()
    }
    
    func addSubscriber() {
        coinDataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
}

