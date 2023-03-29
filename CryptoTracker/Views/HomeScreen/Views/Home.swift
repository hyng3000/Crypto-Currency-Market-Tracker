//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Hamish Young on 21/3/2023.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var showPortfolioList: Bool = false
    
    @State private var showPortfolioSheet = false

    var body: some View {
        ZStack {
            Color.theme.background
            .ignoresSafeArea()
            .sheet(isPresented: $showPortfolioSheet, content: {UserPortfolioView().environmentObject(vm)})
            
            VStack {
                MarketInfoBar(showPortfolio: $showPortfolioList)
                SearchBar(searchtext: $vm.searchtext)
                
                if !showPortfolioList {
                    allMarketCoins
                    Spacer(minLength: 0)
                }
                if showPortfolioList {
                    portfolioCoins
                }
                Spacer()
                HStack {
                    Text("Coin")
                    Spacer()
                    if showPortfolioList {
                        Text("Holdings")
                    }
                    Text("Market Price").frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                }
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
                .padding(.horizontal)
                
                navBar
            }
        }
    }
}

extension HomeView {
    private var navBar: some View {
        HStack {
            CircleButtonView(icon: showPortfolioList ? "plus" : "info")
                .animation(.none, value: showPortfolioList)
                .background(CircleButtonAnimationView(animate: $showPortfolioList))
                .onTapGesture {
                    if showPortfolioList {
                       showPortfolioSheet.toggle()
                    }
                }
                        
            Spacer()
                    
            Text(showPortfolioList ? "Your Portfolio" : "Live Market Data")
                .animation(.easeInOut, value: showPortfolioList)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                        
            Spacer()
                    
            CircleButtonView(icon: "arrow.left.arrow.right")
                .rotationEffect(
                Angle(degrees: showPortfolioList ? -180 : -0)
                )
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolioList.toggle()
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
