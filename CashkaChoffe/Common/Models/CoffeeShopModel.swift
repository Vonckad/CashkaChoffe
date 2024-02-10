//
//  CoffeeShopModel.swift
//  CashkaChoffe
//
//  Created by Vlad Ralovich on 10.02.2024.
//

import Foundation

struct CoffeeShopModel: Codable {
    let id: Int
    let name: String
    let point: Point
}

struct Point: Codable {
    let latitude, longitude: String
}

typealias CoffeeShopModels = [CoffeeShopModel]
