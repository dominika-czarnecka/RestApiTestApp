//
//  ApiManager.swift
//  RestApiTestApp
//
//  Created by Dominika Czarnecka on 22.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import RxSwift
import RxCocoa

class TestApiManager {
    
    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        
        switch apiRequest.self {
        case is CentralRequest:
            return Observable<CentralObject>.create({ (observer) in
                observer.onNext(CentralObject(serialNumber: "serialNumber", mac: "macAdress", softVersion: "softVersion"))
                return Disposables.create()
            })
        case is SectionRequest:
            return Observable<[SectionObject]>.create({ (observer) in
                [SectionObject(id: 1, name: "section", sortOrder: 2), SectionObject(id: 2, name: "section", sortOrder: 1)]
                return Disposables.create()
                 })
        case is RoomRequest:
            return Observable<[RoomObject]>.create({ (observer) in
                [RoomObject(id: 1, name: "room", sectionID: 1, sortOrder: 1), RoomObject(id: 2, name: "room", sectionID: 2, sortOrder: 1)]
                return Disposables.create()
                 })
        default:
            return Observable<CentralObject>.create({ (observer) in
                [CentralObject(serialNumber: "serialNumber", mac: "macAdress", softVersion: "softVersion")]
                return Disposables.create()
                 })
        }
        
    }
    
    func sendWithoutResponse(apiRequest: APIRequest) -> Error? {
        
        return nil
        
    }
    
}
