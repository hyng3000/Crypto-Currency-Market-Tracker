//
//  COinRowView.swift
//  CryptoTracker
//
//  Created by Hamish Young on 22/3/2023.
//

import SwiftUI

struct CoinRowView: View {

    let coin: CoinData
    let showHoldingsColumn: Bool

    var body: some View {
        ZStack {
            roundedRectangleBase
            HStack(spacing: 0) {
                coinNameAndSymbol
                Spacer()
                if showHoldingsColumn {
                    holdings
                }
                marketInfo
            }
        }
    }
}

extension CoinRowView {
    
    var roundedRectangleBase: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(maxWidth: .infinity)
            .frame(height: 70)
            .foregroundColor(Color.theme.background)
            .shadow(radius: 15.0)
    }
    
    var coinNameAndSymbol: some View {
    
        HStack {
             Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
                .frame(minWidth: 30)
            CoinImage(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
                }
            }
            
    var holdings: some View {
        VStack() {
                Text((coin.currentHoldingsValue ).asCurrencyWithTwoDecimals())
                Text((coin.currentHoldings ?? 0).asNumberString())
            }
            .foregroundColor(Color.theme.accent)
    }
    
    var marketInfo: some View {
        VStack(alignment: .center) {
                Text(
                coin.currentPrice.asCurrencyWithSixDecimals()
                ).bold()
                .foregroundColor(Color.theme.accent)
                Text(
                (coin.priceChangePercentage24H ?? 0).asPercentString()
                )
                    .foregroundColor(coin.priceChangePercentage24H ?? 0 >= 0 ? Color.theme.green : Color.theme.red)
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
    
        Group {
        CoinRowView(coin: dev.coin, showHoldingsColumn: true)
        
        CoinRowView(coin: dev.coin, showHoldingsColumn: true)
            .preferredColorScheme(.dark)
        }
    }
}
