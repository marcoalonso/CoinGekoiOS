//
//  CryptocurrencyRepository.swift
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

extension Result {
    var failureValue: Error? {
        switch self {
        case .failure(let error):
            return error
        case .success:
            return nil
        }
    }
}

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

class CryptocurrencyRepository: GlobalCryptoListRepositoryType {
    
    private let apiDataSource: ApiDataSourceType
    private let errorMapper: CryptocurrecncyDomainErrorMapper
    
    init(apiDataSource: ApiDataSourceType, errorMapper: CryptocurrecncyDomainErrorMapper) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
    }
    
    func getGlobalCryptoList() async -> Result<[Cryptocurrecy], CryptocurrecyDomainError> {
        let symbolListResult = await apiDataSource.getGlobalCryptoSymbolList()
        
        let cryptoListResult = await apiDataSource.getCryptoList()
        
        guard case .success(let symbolList) = symbolListResult else {
            return .failure(errorMapper.map(error: symbolListResult.failureValue as? HTTPClientError))

        }
        
        guard case .success(let cryptoList) = cryptoListResult else {
            return .failure(errorMapper.map(error: symbolListResult.failureValue as? HTTPClientError))
        }
        
        var symbolListDic = [String: Bool]()
        symbolList.forEach { symbol in
            symbolListDic[symbol] = true
        }
        
        let globalCryptoList = cryptoList.filter { symbolListDic[$0.symbol] ?? false }
        
        let priceInfoResult = await apiDataSource.getPriceInfoForCryptos(id: globalCryptoList.map { $0.id })

        guard case .success(let priceInfo) = priceInfoResult else {
            return .failure(errorMapper.map(error: symbolListResult.failureValue as? HTTPClientError))
        }
        
        /// *- Convertir esta info en el modelo (Entity) usando el Patron Builder
        
        let cryptoCurrencyBuilderList = globalCryptoList.map { CryptocurrencyBuilder(id: $0.id, name: $0.name, symbol: $0.symbol) }
        ///- Recorrer la lista y comprobar que el id existe en priceInfo
        cryptoCurrencyBuilderList.forEach { cryptocurrencyBuilder in
            if let priceInfo = priceInfo[cryptocurrencyBuilder.id] {
                cryptocurrencyBuilder.price = priceInfo.price
                cryptocurrencyBuilder.volume24h = priceInfo.volume24h
                cryptocurrencyBuilder.marketCap = priceInfo.marketCap
                cryptocurrencyBuilder.price24h = priceInfo.price24h
            }
        }
        
        return .success(cryptoCurrencyBuilderList.compactMap({ $0.build() }))
    }
    
    /// https://api.coingecko.com/api/v3/simple/price?ids=bitcoin.ripple&vs_currencies=usd&include_market_cap=true&include_24hr_vol=true&include_24hr_change=true
    /// https://api.coingecko.com/api/v3/coins/list
    /// https://api.coingecko.com/api/v3/global
    
    
}
