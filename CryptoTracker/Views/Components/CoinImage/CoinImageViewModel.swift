//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Hamish Young on 25/3/2023.
//

import SwiftUI
import Foundation
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = true
    
    private let coin: CoinData
    private let imageService: CoinImageManager
    private var cancellables = Set<AnyCancellable>()
    
    
    init(coin: CoinData){
    
        self.coin = coin
        self.imageService = CoinImageManager(url: coin.image)
        self.subscribeToImage()
        self.isLoading = true
    }
    
    private func subscribeToImage(){
        imageService.$image
        .sink { [weak self] (_) in
            self?.isLoading = false
        } receiveValue: { [weak self] image in
            self?.image = image
        }
        .store(in: &cancellables)
            
        }
    }
    
