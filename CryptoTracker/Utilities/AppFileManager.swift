//
//  AppFileManager.swift
//  CryptoTracker
//
//  Created by Hamish Young on 25/3/2023.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    private init() {}
    
    func saveImage(image: UIImage) {
        
        guard
            let data = image.pngData(),
            let url = URL(string: "")
            else { return }
                
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image. \(error)")
        }
    }
    
    
    
}
