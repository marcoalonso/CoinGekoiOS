//
//  CryptocurrencyBuilder.swift
//  CoinGeko
//
//  Created by Marco Alonso Rodriguez on 24/10/23.
//

import Foundation

class CryptocurrencyBuilder {
    let id: String
    let name: String
    let symbol: String
    var price: Double?
    var price24h: Double?
    var volume24h: Double?
    var marketCap: Double?
    
    init(id: String, name: String, symbol: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
    }
    
    func build() -> Cryptocurrecy? {
        guard let price = price,
              let marketCap = marketCap else { return nil }
        
        return Cryptocurrecy(id: id,
                             name: name,
                             symbol: symbol,
                             price: price,
                             price24h: price24h,
                             volume24h: volume24h,
                             marketCap: marketCap)
    }
    
}
