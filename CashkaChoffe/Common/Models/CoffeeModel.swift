//
//  CoffeeModel.swift
//  CashkaChoffe
//
//  Created by Vlad Ralovich on 11.02.2024.
//

import Foundation

struct CoffeeModel: Codable {
    let id: Int
    let name, imageURL: String
    let price: Int
}

typealias CoffeeModels = [CoffeeModel]
