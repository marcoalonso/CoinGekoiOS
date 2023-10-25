//
//  Foundation+Extensions.swift
//  CoinGeko
//
//  Created by Marco Alonso Rodriguez on 24/10/23.
//

import Foundation

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
