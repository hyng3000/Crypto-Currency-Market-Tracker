//
//  WalletDataManager.swift
//  CryptoTracker
//
//  Created by Hamish Young on 6/4/2023.
//

import Foundation
import CoreData

class WalletDataManager {

    @Published var savedEntities: [WalletEntity] = []
    
    private let container: NSPersistentContainer
    private let containerName: String = "WalletContainer"
    private let walletEntityName: String = "WalletEntity"
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        })
        getWallet()
    }
    
    func updateWallet(coin: CoinData, amount: Double) {
        if let coin = savedEntities.first(where: { $0.id == coin.id }) {
            if amount > 0 {
                updateAmount(entity: coin , amount: amount)
            } else {
                delete(entity: coin)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    
    // Helper Functions
    
    private func getWallet() {
        let request = NSFetchRequest<WalletEntity>(entityName: walletEntityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Unable to load Wallet \(error)")
        }
    }
    
    private func add(coin: CoinData, amount: Double) {
        let entity = WalletEntity(context: container.viewContext)
        entity.name = coin.name
        entity.id = coin.id
        entity.amount = amount
        saveAndUpdate()
    }
    
    private func updateAmount(entity: WalletEntity, amount: Double) {
        entity.amount = amount
        saveAndUpdate()
        
    }
    
    private func save(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("Unable to save Wallet. \(error)")
        }
    }
    
    private func delete(entity: WalletEntity) {
        container.viewContext.delete(entity)
        saveAndUpdate()
    }
    
    private func saveAndUpdate() {
        save()
        getWallet()
    }
    
    
}
