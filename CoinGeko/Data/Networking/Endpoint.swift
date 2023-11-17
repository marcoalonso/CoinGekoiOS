//
//  APICryptoDataSource.swift
//  CoinGeko
//
//  Created by Marco Alonso Rodriguez on 17/11/23.
//

import Foundation

struct Endpoint {
    let path: String
    let queryParameters: [String : Any]
    let method: HTTPMethod
}
