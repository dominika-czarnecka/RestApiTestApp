//
//  ApiManager.swift
//  FibaroRecruitmentApp
//
//  Created by Dominika Czarnecka on 22.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import RxSwift
import RxCocoa

class ApiManager {
    
    private let baseURL = URL(string: "http://styx.fibaro.com:9999/api")!
    
    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = apiRequest.request(with: self.baseURL)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
//                if let error = error {
//                    observer.onError(error)
//                    return
//                }
                do {
                    if let data = data {
                        let model: T = try JSONDecoder().decode(T.self, from: data)
                        observer.onNext(model)
                    }
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func sendWithoutResponse(apiRequest: APIRequest) -> Error? {
        
        let request = apiRequest.request(with: self.baseURL)
        var requestError: Error?
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            requestError = error
        }
        task.resume()
        
        return requestError
        
    }
    
}
