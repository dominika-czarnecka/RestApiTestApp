//
//  UIAlertViewController+Extension.swift
//  RestApiTestApp
//
//  Created by Dominika Czarnecka on 26.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func createWithOKAction(_ title: String?, message: String?) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(alertAction)
        
        return alert
        
    }
    
}
