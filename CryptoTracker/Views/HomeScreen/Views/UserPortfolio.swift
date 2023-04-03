//
//  UserPortfolioView.swift
//  CryptoTracker
//
//  Created by Hamish Young on 29/3/2023.
//

import SwiftUI

struct UserPortfolioView: View {

    @EnvironmentObject private var vm: HomeViewModel
    @State var selectedCoin: CoinData? = nil
    @State private var quantityText: String = ""
    @State var isSaved: Bool = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
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
                ToolbarItem(placement: .bottomBar, content: {saveButton})}
            
            )
            
        }
    }
}

extension UserPortfolioView {
         
    var searchList: some View { ScrollView(.horizontal, showsIndicators: true) {
    
        LazyHStack {
            ForEach(vm.allCoins) { coin in
                CoinLogo(coin: coin)
                    .frame(width: 70, height: 100)
                    .padding(4)
                    .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                                    }
                                }
                                .background{
                                    RoundedRectangle(cornerRadius: 20)
                                        .strokeBorder(
                                        (coin.id == selectedCoin?.id) ? Color.theme.green : Color.theme.accent,
                                        lineWidth: 1)
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
                        .offset(x: -15)
                        .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
                    }
                    .font(.headline)
                    .foregroundColor(Color(UIColor.systemBlue))
    
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
    
        guard selectedCoin != nil else { return }
    
        withAnimation(.easeIn) {
            isSaved = true
        }
    
        UIApplication.shared.appDismissKeyboard()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeInOut) {
                isSaved = false
            }
        }
        
    
    }
    
    func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchtext = ""
    }
}



struct UserPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        UserPortfolioView()
    }
}
