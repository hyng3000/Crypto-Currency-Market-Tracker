//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Hamish Young on 21/3/2023.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {

    @StateObject var vm = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
