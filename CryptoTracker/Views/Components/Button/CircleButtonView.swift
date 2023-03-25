//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by Hamish Young on 21/3/2023.
//

import SwiftUI

struct CircleButtonView: View {

    let icon: String
    
    var body: some View {
        Image(systemName: icon)
        .font(.headline)
        .foregroundColor(Color.theme.accent)
        .frame(width:50, height: 50)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .foregroundColor(Color.theme.background)
        )
        .shadow(
        color: Color.theme.accent.opacity(0.25),
         radius: 10,
         x: 0,
         y: 0
         )
         .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(icon: "info")
            .padding()
            .previewLayout(.sizeThatFits)
            CircleButtonView(icon: "plus")
            .padding()
            .previewLayout(.sizeThatFits)
            .colorScheme(.dark)
        }
    }
}
