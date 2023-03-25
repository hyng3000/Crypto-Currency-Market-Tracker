//
//  CoinImage.swift
//  CryptoTracker
//
//  Created by Hamish Young on 25/3/2023.
//

import SwiftUI


struct CoinImage: View {

    @StateObject var vm: CoinImageViewModel
    
    init(coin: CoinData) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(
        coin: coin))
    }
    

    var body: some View {
    
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryTextColor)
            }
        }
    
    }
}

struct CoinImage_Previews: PreviewProvider {
    static var previews: some View {
        CoinImage(coin: dev.coin)
    }
}
