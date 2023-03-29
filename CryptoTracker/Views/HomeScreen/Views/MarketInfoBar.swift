//
//  MarketDataView.swift
//  CryptoTracker
//
//  Created by Hamish Young on 28/3/2023.
//

import SwiftUI

struct MarketInfoBar: View {

    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool

    var body: some View {
    HStack {
            ForEach(vm.analytics) {
                MarketInfomationView(info: $0)
                    .frame(width: UIScreen.main.bounds.width * 1/3)
                    
            }
            
        }.frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading )
    }
}

struct MarketDataView_Previews: PreviewProvider {
    static var previews: some View {
        MarketInfoBar(showPortfolio: .constant(false))
    }
}
