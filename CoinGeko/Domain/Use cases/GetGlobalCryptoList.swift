//
//  GetGlobalCryptoList.swift
//  CoinGeko
//
//  Created by Marco Alonso Rodriguez on 24/10/23.
//

import Foundation

class GetGlobalCryptoList {
    private let repository: GlobalCryptoListRepositoryType
    
    init(repository: GlobalCryptoListRepositoryType) {
        self.repository = repository
    }
    
    func execute() async -> Result<[Cryptocurrecy], CryptocurrecyDomainError> {
        let result = await repository.getGlobalCryptoList()
        
        guard let cryptoList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            return .failure(error)
        }
        
        return .success(cryptoList.sorted { $0.marketCap > $1.marketCap })
    }
    
}
