//
//  CoinModel.swift
//  CryptoCoinMVVM
//
//  Created by Alok Kumar Naik on 26/03/2021.
//

import Foundation

struct CryptoDataContainer: Decodable {
    
    let status: String
    let data: CryptoData
}

struct CryptoData: Decodable{
    
    let coins:[Coin]
}

struct Coin: Decodable, Hashable {
    
    let name: String
    let price: String
}
