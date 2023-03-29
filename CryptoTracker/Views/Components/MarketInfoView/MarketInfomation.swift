//
//  MarketInfomationView.swift
//  CryptoTracker
//
//  Created by Hamish Young on 28/3/2023.
//

import SwiftUI

struct MarketInfomationView: View {

    let info: AnalyticsModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(info.title)
                .font(.caption)
            Text(info.value)
                .font(.headline)
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption)
                    .rotationEffect(
                    Angle(degrees: info.percentagechange ?? 0 >= 0   ? 0 : 180))
                Text("\(info.percentagechange?.asPercentString()  ?? "0.0")")
                    .font(.caption)
                }
                .foregroundColor(info.percentagechange ?? 0.0 >= 0.0 ? Color.theme.green : Color.theme.red)
        }
    }
}

struct MarketInfomationView_Previews: PreviewProvider {
    static var previews: some View {
        MarketInfomationView(info: DeveloperPreview.instance.analtics2)
    }
}
