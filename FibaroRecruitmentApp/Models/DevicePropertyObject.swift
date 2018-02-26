//
//  DevicePropertiesObject.swift
//  FibaroRecruitmentApp
//
//  Created by Dominika Czarnecka on 24.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit

struct DevicePropertyObject: Codable {

    let dead: Bool
    let disabled: Bool
    let value: Double?
    
    enum CodingKeys: String, CodingKey {
        case dead
        case disabled
        case value
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        dead = (try? values.decode(String.self, forKey: .dead)) == "1" ? true : false
        disabled = (try? values.decode(String.self, forKey: .disabled)) == "1" ? true : false
        value = Double((try? values.decode(String.self, forKey: .value)) ?? "0")
        
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let isDead = dead ==  true ? "1" : "0"
        try? container.encode(isDead, forKey: .dead)
        
        let isDisabled = disabled == true ? "1" : "0"
        try? container.encode(isDisabled, forKey: .disabled)
  
        try? container.encode(value?.description, forKey: .value)
        
    }
    
}
