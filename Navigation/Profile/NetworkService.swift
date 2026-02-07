//
//  NetworkService.swift
//  Navigation
//
//  Created by kubmakk on 6/2/26.
//

import Foundation

struct ProductResponse: Codable {
    let products: [ApiPost]
}

struct ApiPost: Codable {
    let id: Int
    let title: String
    let description: String
    let thumbnail: String // Прямая ссылка на картинку
}

enum NetworkError: Error{
    case invalidURL
    case noData
    case unknown
}

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchPosts(completion: @escaping (Result<[ApiPost], Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/products") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ProductResponse.self, from: data)
                
                completion(.success(result.products))
            } catch {
                print("Decoding error: \(error)") 
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
