//
//  CryptocurrencyRepository.swift
//  CoinGeko
//
//  Created by Marco Alonso Rodriguez on 24/10/23.
//

import Foundation

///* Su funcion es orquestar los servicios a los que hay que llamar para obtener los datos, se los pasa al mapper para que se encargue de unificarlos y obtener el array de builders para obtener los precios.
class CryptocurrencyRepository: GlobalCryptoListRepositoryType {
    
    private let apiDataSource: ApiDataSourceType
    private let errorMapper: CryptocurrecncyDomainErrorMapper
    private let domainMapper: CryptocurrencyDomainMapper
    
    init(apiDataSource: ApiDataSourceType, errorMapper: CryptocurrecncyDomainErrorMapper, domainMapper: CryptocurrencyDomainMapper) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
        self.domainMapper = domainMapper
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
        
        let cryptoCurrencyBuilderList = domainMapper.getCryptocurrencyBuilderList(symbolList: symbolList, cryptoList: cryptoList)
        
        let priceInfoResult = await apiDataSource.getPriceInfoForCryptos(id: cryptoCurrencyBuilderList.map { $0.id })

        guard case .success(let priceInfo) = priceInfoResult else {
            return .failure(errorMapper.map(error: symbolListResult.failureValue as? HTTPClientError))
        }
        
        return .success(domainMapper.map(cryptoCurrencyBuilderList: cryptoCurrencyBuilderList, priceInfo: priceInfo))
    }
    
}
