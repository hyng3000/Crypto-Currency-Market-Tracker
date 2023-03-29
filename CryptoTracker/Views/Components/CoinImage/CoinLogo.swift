//
//  CoinLogo.swift
//  CryptoTracker
//
//  Created by Hamish Young on 29/3/2023.
//

import SwiftUI

struct CoinLogo: View {

    let coin: CoinData

    var body: some View {
    
        VStack {
            CoinImage(coin: coin)
            Text(coin.name)
            Text(coin.symbol.uppercased()).font(.title)
                
        }
        
    }
}

struct CoinLogo_Previews: PreviewProvider {
    static var previews: some View {
        CoinLogo(coin: dev.coin)
    }
}
