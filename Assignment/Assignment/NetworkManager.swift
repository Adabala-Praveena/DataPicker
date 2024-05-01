//
//  NetworkManager.swift
//  Assignment
//
//  Created by Praveena on 01/05/24.
//

import Foundation

/// A singleton class responsible for handling network requests related to dataArr.
class NetworkManager {
    /// Shared instance of the network manager.
    static let shared = NetworkManager()
    
    /// Private initializer to prevent external initialization.
    private init() {}
    
    /// Fetches dataArr from a remote server.
    ///
    /// - Parameter completion: A closure to be executed when the fetch operation completes, providing the result of the operation.
    func fetchData(completion: @escaping (Result<[InputData], Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.failedRequest))
                return
            }
            do {
                let dataArr = try JSONDecoder().decode([InputData].self, from: data)
                completion(.success(dataArr))
            } catch {
                completion(.failure(NetworkError.invalidResponse))
            }
        }.resume()
    }
}

/// An enumeration representing network-related errors.
enum NetworkError: Error {
    /// Indicates that the URL provided is invalid.
    case invalidURL
    /// Indicates that the network request failed.
    case failedRequest
    /// Indicates that the response from the server is invalid.
    case invalidResponse
}
