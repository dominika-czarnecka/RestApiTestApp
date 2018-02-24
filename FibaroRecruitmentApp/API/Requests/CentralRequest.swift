//
//  CentralRequest.swift
//  FibaroRecruitmentApp
//
//  Created by Dominika Czarnecka on 24.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

struct CentralRequest: APIRequest {
    
    var method = RequestType.GET
    var path = "settings/info"
    var parameters = [String: String]()
    var isAuthRequired = false
    
}
