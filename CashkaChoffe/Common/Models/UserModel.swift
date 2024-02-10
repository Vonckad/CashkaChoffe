//
//  UserModel.swift
//  CashkaChoffe
//
//  Created by Vlad Ralovich on 10.02.2024.
//

import Foundation

struct UserModel: Codable {
    let login: String
    let password: String
}

struct TokenModel: Decodable {
    let token: String
}
