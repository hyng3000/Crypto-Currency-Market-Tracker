//
//  AppFileManager.swift
//  CryptoTracker
//
//  Created by Hamish Young on 25/3/2023.
//

import Foundation
import SwiftUI

class AppFileManager {
    
    static let instance = AppFileManager()
    private init() {}
    
    func saveUIImage(_ image: UIImage, as name: String, in directoryName: String) {
    
        createDirectoryIfNeeded(directoryName: directoryName)
    
        guard
            let data = image.pngData(),
            let url = getPathForPNGImage(imageName: name, directoryName: directoryName)
            else { return }
                
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image: '\(name)' \(error)")
        }
    }
    
    func getImage(imageName: String, directoryName: String) -> UIImage? {
        guard
            let url = getPathForPNGImage(imageName: imageName, directoryName: directoryName),
            FileManager.default.fileExists(atPath: url.path)
        else { return nil }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    
    
    
    
    
    private func createDirectoryIfNeeded(directoryName: String) {
        guard let url = getUrlForDirectory(directoryName: directoryName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do { try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil) }
            catch let e {
                print("Error creating directory: '\(directoryName)' -> \(e)")
            }
        }
    }
    
    private func getUrlForDirectory(directoryName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(directoryName)
    }
    
    private func getPathForPNGImage(imageName: String, directoryName: String) -> URL? {
        guard let parent = getUrlForDirectory(directoryName: directoryName) else { return nil }
        return parent.appendingPathComponent(imageName + ".png")
    }
    
}
