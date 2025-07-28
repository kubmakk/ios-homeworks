//
//  NetworkService.swift
//  Navigation
//
//  Created by kubmakk on 28.07.2025.
//

import Foundation

struct NetworkService {
    static func reqiuest(for config: AppConfiguration){
        let urlString: String
        switch config {
        case .people(let url):
            urlString = url
        case .planets(let url):
            urlString = url
        case .starships(let url):
            urlString = url
        }
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
       
    }
        
    }

enum AppConfiguration{
    case people(String)
    case starships(String)
    case planets(String)
}
