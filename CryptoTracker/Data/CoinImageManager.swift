//
//  CoinImageManager.swift
//  CryptoTracker
//
//  Created by Hamish Young on 25/3/2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageManager {

    @Published var image: UIImage? = nil

    var imageSubscription: AnyCancellable?

    init(url: String) {
        getCoinImage(from: url)
    }
    
    private func getCoinImage(from url: String) {
        guard let url = URL(string: url) else { return }
        
        imageSubscription = NetworkingManager.download(from: url)
            .tryMap {   (data) -> UIImage? in
                return UIImage(data: data)
            }
            .sink(
            receiveCompletion: NetworkingManager.completionHandler,
            receiveValue: { [weak self] (image) in
                self?.image = image
                self?.imageSubscription?.cancel()
            })
            
    }
    
}


