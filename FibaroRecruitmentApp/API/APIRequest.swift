//
//  APIRequest.swift
//  FibaroRecruitmentApp
//
//  Created by Dominika Czarnecka on 22.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit

protocol APIRequest {
    
    var method: RequestType { get }
    var path: String { get }
    var parameters: [String : String] { get }
    var isAuthRequired: Bool { get }
    
}

extension APIRequest {
    
    func request(with baseURL: URL) -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }
        
        if isAuthRequired {
            components.user = "admin"
            components.password = "admin"
        }
        
        guard let url = components.url else {
            fatalError("Could not get url")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
}
