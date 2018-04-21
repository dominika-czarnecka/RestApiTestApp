//
//  DeviceRequest.swift
//  RestApiTestApp
//
//  Created by Dominika Czarnecka on 24.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit

struct DeviceRequest: APIRequest {
    
    var method = RequestType.GET
    var path = "devices"
    var parameters = [String : String]()
    var isAuthRequired = true
    
}
