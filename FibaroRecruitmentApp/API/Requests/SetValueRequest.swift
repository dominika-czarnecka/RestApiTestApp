//
//  SetValueRequest.swift
//  FibaroRecruitmentApp
//
//  Created by Dominika Czarnecka on 25.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit

struct SetValueRequest: APIRequest {
    
    var method = RequestType.GET
    var path = "callAction"
    var parameters: [String: String]
    var isAuthRequired = true
    
    init(_ deviceID: Int, value: Double) {
        
        self.parameters = [
            "deviceID": deviceID.description,
            "name": "setValue",
            "arg1": value.description
            
        ]
    }
}
