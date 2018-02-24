//
//  DevicesActionObject.swift
//  FibaroRecruitmentApp
//
//  Created by Dominika Czarnecka on 24.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit

struct DevicesActionObject: Codable {

    let setValue: Double?
    let tunfOff: Int?
    let turnOn: Int?
    
    init(_ value: Double, setOn: Bool ) {
        setValue = value
        turnOn = setOn ? 1 : 0
        tunfOff = setOn ? 0 : 1
    }
    
}
