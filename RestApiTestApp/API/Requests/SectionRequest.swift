//
//  SectionRequest.swift
//  RestApiTestApp
//
//  Created by Dominika Czarnecka on 24.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

struct SectionRequest: APIRequest {

    var method = RequestType.GET
    var path = "sections"
    var parameters = [String: String]()
    var isAuthRequired = true

}
