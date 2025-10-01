//
//  NetworkManager.swift
//  myRealmProj
//
//  Created by kubmakk on 1/10/25.
//

import Foundation

struct QuoteData: Decodable {
    let id: String
    let value: String
    let categories: [String]
}

class NetworkManager {
    static let shared = NetworkManager()
    private let url = URL(string: "https://api.chucknorris.io/jokes/random")!

    private init() {}

    func fetchQuote(completion: @escaping (Result<QuoteData, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "NetworkManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }	

            do {
                let quoteData = try JSONDecoder().decode(QuoteData.self, from: data)
                completion(.success(quoteData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/categories") else {
            completion(.failure(NSError(domain: "NetworkManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Bad URL"])));
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "NetworkManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])));
                return
            }

            do {
                let categories = try JSONDecoder().decode([String].self, from: data)
                completion(.success(categories))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchQuote(forCategory category: String, completion: @escaping (Result<QuoteData, Error>) -> Void) {
        guard var components = URLComponents(string: "https://api.chucknorris.io/jokes/random") else {
            completion(.failure(NSError(domain: "NetworkManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Bad URL"])));
            return
        }
        components.queryItems = [URLQueryItem(name: "category", value: category)]
        guard let url = components.url else {
            completion(.failure(NSError(domain: "NetworkManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Bad URL components"])));
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "NetworkManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])));
                return
            }

            do {
                let quoteData = try JSONDecoder().decode(QuoteData.self, from: data)
                completion(.success(quoteData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
