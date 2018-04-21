//
//  TurnRequest.swift
//  RestApiTestApp
//
//  Created by Dominika Czarnecka on 25.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit

struct TurnRequest: APIRequest {
    
    var method = RequestType.GET
    var path = "callAction"
    var parameters: [String: String]
    var isAuthRequired = true
    
    init(_ deviceID: Int, turnOn: Bool) {
        
        self.parameters = [
            "deviceID": deviceID.description,
            "name": (turnOn ? "turnOn" : "turnOff")
        ]
    }
}
