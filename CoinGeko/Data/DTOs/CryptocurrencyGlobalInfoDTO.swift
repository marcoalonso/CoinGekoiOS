//
//  CryptocurrencyGlobalInfoDTO.swift
//  CoinGeko
//
//  Created by Marco Alonso Rodriguez on 17/11/23.
//

import Foundation

struct CryptocurrencyGlobalInfoDTO: Codable {
    let data: CryptocurrencyGlobalData
    
    struct CryptocurrencyGlobalData: Codable {
        let cryptocurrencies: [String : Double]
        
        enum CodingKeys: String, CodingKey {
            case cryptocurrencies = "market_cap_percentage"
        }
    }
}
