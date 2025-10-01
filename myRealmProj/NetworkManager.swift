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
