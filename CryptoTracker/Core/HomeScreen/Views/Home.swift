//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Hamish Young on 21/3/2023.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var showPortoflio: Bool = false

    var body: some View {
        ZStack {
            Color.theme.background
            .ignoresSafeArea()
            
            VStack {
                navHeader
                
                HStack {
                    Text("Coin")
                    Spacer()
                    if showPortoflio {
                        Text("Holdings")
                    }
                    Text("Market Price").frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                }
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
                .padding(.horizontal)
                
                
                if !showPortoflio {
                    allMarketCoins
                    Spacer(minLength: 0)
                }
                if showPortoflio {
                    portfolioCoins
                }
                
            }
            Spacer(minLength: 0)
        }
    }
}

extension HomeView {
    private var navHeader: some View {
        HStack {
            CircleButtonView(icon: showPortoflio ? "plus" : "info")
                .animation(.none, value: showPortoflio)
                .background(CircleButtonAnimationView(animate: $showPortoflio))
                        
            Spacer()
                    
            Text(showPortoflio ? "Your Portfolio" : "Live Market Data")
                .animation(.easeInOut, value: showPortoflio)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                        
            Spacer()
                    
            CircleButtonView(icon: "chevron.right")
                .rotationEffect(
                Angle(degrees: showPortoflio ? 180 : 0)
                )
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortoflio.toggle()
                    }
                }
        }.padding()
    }
    
    private var allMarketCoins: some View {
        List {
                ForEach(vm.allCoins) { coin in
                    CoinRowView(coin: coin, showHoldingsColumn: false)
                        .listRowInsets(.init(top: 10, leading: 5, bottom: 10, trailing: 5))
                    }
            }
                .listStyle(.plain)
                .transition(.move(edge: .leading))
    }
    
    private var portfolioCoins: some View {
         List {
            ForEach(vm.portfolioCoins) { coin in
            CoinRowView(coin: coin, showHoldingsColumn: true)
                .listRowInsets(.init(top: 10, leading: 5, bottom: 10, trailing: 5))
            }
        }
        .listStyle(.plain)
        .transition(.move(edge: .trailing))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
    NavigationView {
            HomeView().navigationBarHidden(true)
            }.environmentObject(dev.devViewModel)
        }
    }
