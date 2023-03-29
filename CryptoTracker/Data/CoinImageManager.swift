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
    private let coin: CoinData
    var imageSubscription: AnyCancellable?
    
    let directoryName = "coin_images"

    init(coin: CoinData) {
        self.coin = coin
        getCoinImage(name: coin.name)
    }
    
    private func getCoinImage(name: String) {
        if let savedImage = AppFileManager.instance.getImage(imageName: name, directoryName: directoryName) {
            image = savedImage
        } else {
            downloadcoinImage(from: coin.image)
        }
    }
    
    private func downloadcoinImage(from url: String) {
        guard let url = URL(string: url) else { return }
        
        imageSubscription = NetworkingManager.download(from: url)
            .tryMap {   (data) -> UIImage? in
                return UIImage(data: data)
            }
            .sink(
            receiveCompletion: NetworkingManager.completionHandler,
            receiveValue: { [weak self] (image) in
            
                guard let self = self, let image else { return }
                self.image = image
                self.imageSubscription?.cancel()
                AppFileManager.instance.saveUIImage(image, as: self.coin.name, in: self.directoryName)
            })
    }
    
}


