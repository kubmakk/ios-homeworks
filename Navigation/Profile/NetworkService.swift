//
//  NetworkService.swift
//  Navigation
//
//  Created by kubmakk on 6/2/26.
//

import Foundation

struct ApiPost: Codable {
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
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
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let posts = try JSONDecoder().decode([ApiPost].self, from: data)
                let firstPosts = Array(posts.prefix(10))
                completion(.success(firstPosts))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
