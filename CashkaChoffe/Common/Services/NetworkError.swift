//
//  NetworkError.swift
//  CashkaChoffe
//
//  Created by Vlad Ralovich on 10.02.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case errorEncodingJson
    case nilResponse
    case errorDecodingJson
}
