//
//  DeviceObject.swift
//  FibaroRecruitmentApp
//
//  Created by Dominika Czarnecka on 24.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit

struct DeviceObject: Codable {
    
    let id: Int
    let name: String?
    let sortOrder: Int?
    let roomID: Int?
    let type: DeviceType?
    let properties: DevicePropertyObject?
    //let action: DevicesActionObject?

    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case sortOrder
        case roomID
        case type
        case properties
        
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try? values.decode(String.self, forKey: .name)
        sortOrder = try? values.decode(Int.self, forKey: .sortOrder)
        roomID = try? values.decode(Int.self, forKey: .roomID)
        type = DeviceType(rawValue: (try? values.decode(String.self, forKey: .type)) ?? "unknown")
        properties = try? values.decode(DevicePropertyObject.self, forKey: .properties)
        
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(id, forKey: .id)
        try? container.encode(name, forKey: .name)
        try? container.encode(sortOrder, forKey: .sortOrder)
        try? container.encode(roomID, forKey: .roomID)
        try? container.encode(type?.rawValue, forKey: .type)
        try? container.encode(properties, forKey: .properties)
        
    }
    
}
