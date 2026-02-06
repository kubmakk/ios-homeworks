//
//  NetworkService.swift
//  Navigation
//
//  Created by kubmakk on 6/2/26.
//

import Foundation

struct ApiPost: Decodable {
    let userId: Int
    let id: Int
    let url: String
    let thumbnaiUrl: String
    let title: String
}

enum NetworkError: Error{
    case invalidURL
    case noData
    case unknown
}

final class NetworkService {
    static let shared = NetworkService()
    private init(){}
    
    func fethPosts(completion: @escaping (Result<[ApiPost], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        
        URLSession.shared.dataTask(with: url){data, responce, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let posts = try JSONDecoder().decode([ApiPost].self, from: data)
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
