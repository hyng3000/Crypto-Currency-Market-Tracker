//
//  Exit.swift
//  CryptoTracker
//
//  Created by Hamish Young on 29/3/2023.
//

import SwiftUI


struct ExitButton: View {

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(
            action: {
                dismiss()
                },
            label: {
                Image(systemName: "xmark")
                    .font(.headline)
            })
    }
}

struct Exit_Previews: PreviewProvider {
    static var previews: some View {
        ExitButton()
    }
}
