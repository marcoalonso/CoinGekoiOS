//
//  CryptocurrecncyDomainErrorMapper.swift
//  CoinGeko
//
//  Created by Marco Alonso Rodriguez on 24/10/23.
//

import Foundation

class CryptocurrecncyDomainErrorMapper {
    func map(error: HTTPClientError?) -> CryptocurrecyDomainError {
        return .generic
    }
}
