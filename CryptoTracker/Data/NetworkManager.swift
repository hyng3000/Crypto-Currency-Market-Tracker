//
//  NetworkManager.swift
//  CryptoTracker
//
//  Created by Hamish Young on 25/3/2023.
//

import Foundation
import Combine

class NetworkingManager {

    enum NetworkingErrors: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
    
        var errorDesciption: String? {
        switch self {
            case .badURLResponse(url: let url): return "Bad Response from URL: \(url)"
            case .unknown: return "Unknown Error"
            }
        }
    }
    
    
    
    
    static func download(from url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { try handleURLResponse(output: $0, url: url) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
            guard let response = output.response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode <= 300 else {
                    print("handleURLResponse - NetworkManager - .badURL")
                    throw NetworkingErrors.badURLResponse(url: url)
                }
            return output.data
        }
    
    static func completionHandler(completion: Subscribers.Completion<Error>) {
        switch completion {
            case .finished:
                break
            case .failure(let error):
                print("CompletionHandler - NetworkManager: " + error.localizedDescription)
            }
        }
    
}
