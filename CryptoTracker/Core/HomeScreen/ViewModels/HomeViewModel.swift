//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Hamish Young on 22/3/2023.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    

    @Published var allCoins: [CoinData] = []
    @Published var portfolioCoins: [CoinData] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        
        for _ in 0...10 {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
            }
        }
    }
}

