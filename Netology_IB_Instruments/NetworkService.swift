//
//  NetworkService.swift
//  Netology_IB_Instruments
//
//  Created by ALEKSANDR POZDNIKIN on 13.07.2022.
//

import Foundation

struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        switch configuration {
        case .first(let uRL):
            dataTask(uRL: uRL)
        case .second(let uRL):
            dataTask(uRL: uRL)
        case .third(let uRL):
            dataTask(uRL: uRL)
        }
    }
}

enum AppConfiguration {
    case first (URL)
    case second (URL)
    case third (URL)
}
func dataTask(uRL: URL){
    let task = URLSession.shared.dataTask(with: uRL) { data, response, error in
        if let data = data {
            print("🍏 \(data) \(String(data: data, encoding: .nextstep))")
        }
        if let response = response as? HTTPURLResponse {
            print("🍎 \(response.statusCode), \(response.allHeaderFields)")
        }
        if let error = error {
            print("🍋 \(error.localizedDescription)")
        }
    }
    task.resume()
}
