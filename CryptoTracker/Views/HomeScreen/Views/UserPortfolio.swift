//
//  UserPortfolioView.swift
//  CryptoTracker
//
//  Created by Hamish Young on 29/3/2023.
//

import SwiftUI

struct UserWalletView: View {

    @EnvironmentObject private var vm: HomeViewModel
    @State var selectedCoin: CoinData? = nil
    @State private var quantityText: String = ""
    @State var isSaved: Bool = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
                ScrollView {
                    VStack {
                
                        SearchBar(searchtext: $vm.searchtext)
                        searchList
                        if selectedCoin != nil {
                            walletEditingStack
                        }
                    }
                }
            .navigationTitle("Edit")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading, content: {ExitButton(action: dismiss.callAsFunction)})
                ToolbarItem(placement: .navigationBarTrailing, content: {saveButton})}
            )
            .onChange(of: vm.searchtext, perform: { value in
                if value == "" {
                    removeSelectedCoin()
                }
            
            })
            
        }
    }
}

extension UserWalletView {
         
    var searchList: some View { ScrollView(.horizontal, showsIndicators: true) {
    
        LazyHStack {
            ForEach(
            vm.searchtext.isEmpty ?
                vm.walletCoins.isEmpty ? vm.allCoins : vm.walletCoins
            : vm.allCoins) { coin in
                CoinLogo(coin: coin)
                    .frame(width: 70, height: 100)
                    .padding(4)
                    .onTapGesture {
                            withAnimation(.easeIn) {
                                getSelectedCoinAmount(coin: coin)
                                    }
                                }
                                .background{
                                    selectCoinBorder(coin: coin)
                                    }
                                }.padding(5)
                            }
                        }
                    }
                    
    var walletEditingStack: some View {
        VStack(spacing: 20) {
                HStack {
                    Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "")")
                    Spacer()
                    Text(selectedCoin?.currentPrice.asCurrencyWithSixDecimals() ?? "")
                }.padding()
                                
                Divider()
                HStack {
                    Text("Amount in your portfolio: ")
                    Spacer()
                    TextField("Example: 3.9", text: $quantityText)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                    }
                    .padding()
                Divider()
                HStack {
                    Text("Value in AUD: ")
                    Spacer()
                    Text(
                    getValueInAUD(
                        amount: quantityText,
                        coin: selectedCoin
                        ).asCurrencyWithTwoDecimals())
                    }.padding()
                }
                .animation(.none)
                .font(.headline)
    }
    
    var saveButton: some View {
        Button(action: {
                    
                    saveButtonPressed()
                
                }){
                    HStack {
                        Image(systemName: "checkmark")
                            .opacity(isSaved ? 1.0 : 0.0)
                        Text("Save")
                        }
                        .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
                    }
                    .font(.headline)
                    .foregroundColor(Color(UIColor.systemBlue))
    
    }
    
    @ViewBuilder
    func selectCoinBorder(coin: CoinData) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .strokeBorder(
                (coin.id == selectedCoin?.id) ?
                Color.theme.green : Color.theme.accent,
                lineWidth: 1)
    } 
    
    func getValueInAUD(amount: String, coin: CoinData?) -> Double {
    if let amount = Double(amount),
       let coin = coin {
          return amount * coin.currentPrice
        }
        else {
            return 0.0
        }
    }

    

    func saveButtonPressed() {
    
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
            else { return }
    
        vm.updateWallet(coin: coin, amount: amount)
    
        withAnimation(.easeIn) {
            isSaved = true
        }
    
        UIApplication.shared.appDismissKeyboard()
        vm.searchtext = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeInOut) {
                isSaved = false
            }
        
        }
        
    
    }
    
    private func getSelectedCoinAmount(coin: CoinData) {
        selectedCoin = coin
        
        if let coinInWallet = vm.walletCoins.first(where: {$0.id == coin.id}) {
            let amount = coinInWallet.currentHoldings
            quantityText = amount?.asNumberString() ?? ""
            
        }
            
        
    }
    
    func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchtext = ""
    }
    
}



struct UserPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        UserWalletView()
    }
}
