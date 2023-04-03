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
                .frame(width: 50, height: 50)
            Text(coin.name)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.symbol.uppercased()).font(.title)
                .font(.caption)
                .foregroundColor(Color.theme.accent)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }.padding()
        
    }
}

struct CoinLogo_Previews: PreviewProvider {
    static var previews: some View {
        CoinLogo(coin: dev.coin)
    }
}
