//
//  Analytics.swift
//  CryptoTracker
//
//  Created by Hamish Young on 28/3/2023.
//

import Foundation

struct AnalyticsModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentagechange: Double?
    
    init(title: String, value: String, percentagechange: Double? = nil){
        self.title = title
        self.value = value
        self.percentagechange = percentagechange
    }
    
}


