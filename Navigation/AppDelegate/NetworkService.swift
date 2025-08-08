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
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Произошла ошибка: \(error.localizedDescription). Код ошибки \(error._code)")
                    return
                }
                //код ошибки: -1003
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("------Получаем данные-----")
                    print("Статус код: \(httpResponse.statusCode)")
                    print("All Header Fields: \(httpResponse.allHeaderFields)")
                }
                
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("------ Полученные данные ------")
                    print(dataString)
                    print("-----------------------------")
                }
                }
                
            }
        task.resume()
        }
       
    }
        
    
enum AppConfiguration{
    case people(String)
    case starships(String)
    case planets(String)
}
