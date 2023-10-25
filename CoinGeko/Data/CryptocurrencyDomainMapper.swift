//
//  CryptocurrencyDomainMapper.swift
//  CoinGeko
//
//  Created by Marco Alonso Rodriguez on 24/10/23.
//

import Foundation

/// Su funcion será pasar de DTO a modelo de dominio
class CryptocurrencyDomainMapper {
    func getCryptocurrencyBuilderList(symbolList: [String], cryptoList: [CryptocurrecnyBasicDTO]) -> [CryptocurrencyBuilder] {
        var symbolListDic = [String: Bool]()
        symbolList.forEach { symbol in
            symbolListDic[symbol] = true
        }
    
        /// *-  Construir el array de builders y luego modificarlo
        let globalCryptoList = cryptoList.filter { symbolListDic[$0.symbol] ?? false }
        
        let cryptoCurrencyBuilderList = globalCryptoList.map { CryptocurrencyBuilder(id: $0.id, name: $0.name, symbol: $0.symbol) }
        
        return cryptoCurrencyBuilderList
    }
    
    
    func map(cryptoCurrencyBuilderList: [CryptocurrencyBuilder], priceInfo: [String: CryptocurrencyPriceInfoDTO]) -> [Cryptocurrecy] {
        ///- Recorrer la lista y comprobar que el id existe en priceInfo
        cryptoCurrencyBuilderList.forEach { cryptocurrencyBuilder in
            if let priceInfo = priceInfo[cryptocurrencyBuilder.id] {
                cryptocurrencyBuilder.price = priceInfo.price
                cryptocurrencyBuilder.volume24h = priceInfo.volume24h
                cryptocurrencyBuilder.marketCap = priceInfo.marketCap
                cryptocurrencyBuilder.price24h = priceInfo.price24h
            }
        }
        
        return cryptoCurrencyBuilderList.compactMap({ $0.build() })
    }
}
