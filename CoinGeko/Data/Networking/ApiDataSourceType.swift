//
//  ApiDataSourceType.swift
//  CoinGeko
//
//  Created by Marco Alonso Rodriguez on 24/10/23.
//

import Foundation

protocol ApiDataSourceType {
    func getGlobalCryptoSymbolList() async -> Result<[String], HTTPClientError>
    func getCryptoList() async -> Result<[CryptocurrecnyBasicDTO], HTTPClientError>
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String: CryptocurrencyPriceInfoDTO], HTTPClientError>
}
