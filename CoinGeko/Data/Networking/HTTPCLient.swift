//
//  APICryptoDataSource.swift
//  CoinGeko
//
//  Created by Marco Alonso Rodriguez on 17/11/23.
//

import Foundation

protocol HTTPCLient {
    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError>
}
