//
//  Network.swift
//  CashkaChoffe
//
//  Created by Vlad Ralovich on 10.02.2024.
//

import Foundation

enum Network {
    
    enum RequsetType {
        case register, login, locations, menu(id: Int)
        
        var path: String {
            switch self {
            case .register: return "auth/register"
            case .login: return "auth/login"
            case .locations: return "locations"
            case .menu(id: let id): return "location/\(id)/menu"
            }
        }
    }
    
    private static let baseURL = "http://147.78.66.203:3210/"
    private static let queue = DispatchQueue(label: "com.CashkaChoffe.network-manager", attributes: .concurrent)
    private static var session = URLSession(configuration: URLSessionConfiguration.default,
                                     delegate: nil,
                                     delegateQueue: nil)
    static var token: String = ""
    
    private static var paramertsNil: String? = nil

    static func sendRequest<U: Encodable, T: Decodable>(route: RequsetType, paramerts: U? = paramertsNil, decodeTo: T.Type, completion: @escaping (T?, NetworkError?) -> Void) {
        
        queue.async {
            
            guard let url = URL(string: self.baseURL + route.path) else {
                completion(nil, NetworkError.invalidURL)
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = paramerts == nil ? "GET" : "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            if paramerts == nil {
                request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            if let paramerts = paramerts {
                guard let jsonData = try? JSONEncoder().encode(paramerts) else {
                    completion(nil, NetworkError.errorEncodingJson)
                    return
                }
                
                request.httpBody = jsonData
            }
            
            let task = self.session.dataTask(with: request) {  data, response, error in
                
                DispatchQueue.main.async {
                    
                    guard let data = data, error == nil else {
                        completion(nil, NetworkError.nilResponse)
                        return
                    }
                    
                    guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                        completion(nil, NetworkError.errorDecodingJson)
                        return
                    }
                    
                    completion(result, nil)
                    
                }
            }
            
            task.resume()
        }
        
    }
}
