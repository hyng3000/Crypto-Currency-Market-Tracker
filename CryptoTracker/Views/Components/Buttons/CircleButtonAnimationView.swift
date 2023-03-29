//
//  CircleButtonAnimationView.swift
//  CryptoTracker
//
//  Created by Hamish Young on 22/3/2023.
//

import SwiftUI

struct CircleButtonAnimationView: View {

    @Binding var animate: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .stroke(lineWidth: 3.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeInOut(duration: 0.5) : .none, value: animate)
    }
    
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(animate: .constant(true))
            .padding()
    }
}
