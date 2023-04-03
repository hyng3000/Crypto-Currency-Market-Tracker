//
//  Exit.swift
//  CryptoTracker
//
//  Created by Hamish Young on 29/3/2023.
//

import SwiftUI


struct ExitButton: View {

    let action: (() -> Void)?
    let dismiss: DismissAction?
    
    init(action: @escaping () -> Void) {
        self.action = action
        self.dismiss = nil
    }
    
    init(dismiss: DismissAction) {
        self.dismiss = dismiss
        self.action = nil
    }
    
    var body: some View {
        Button(
            action: {
                if let dismiss {
                    dismiss()
                } else {
                    if let action{
                        action()
                    }
                }
                },
            label: {
                Image(systemName: "xmark")
                    .font(.headline)
            })
    }
}

struct Exit_Previews: PreviewProvider {
    static var previews: some View {
        ExitButton(action: {})
    }
}
