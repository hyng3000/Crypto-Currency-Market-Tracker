//
//  UserPortfolioView.swift
//  CryptoTracker
//
//  Created by Hamish Young on 29/3/2023.
//

import SwiftUI

struct UserPortfolioView: View {

    @EnvironmentObject private var vm: HomeViewModel

    var body: some View {
        NavigationView {
            ScrollView {
            
            
                VStack {
                    SearchBar(searchtext: $vm.searchtext)
                    ScrollView {
                        LazyVGrid
                    }
                }
            }
            .navigationTitle("Edit")
            .toolbar(content:
                {ToolbarItem(placement: .bottomBar, content: {
                ExitButton()
            })}
            
            )
            
        }
    }
}

struct UserPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        UserPortfolioView()
    }
}
