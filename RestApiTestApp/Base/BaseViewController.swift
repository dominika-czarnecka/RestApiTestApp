//
//  BaseViewController.swift
//  RestApiTestApp
//
//  Created by Dominika Czarnecka on 24.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    internal let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainBlue
        
        configureSubViews()
        configureConstraints()
        bind()
        
    }
    
    func configureSubViews() { }
    
    func configureConstraints() { }
    
    func bind() {}
}
