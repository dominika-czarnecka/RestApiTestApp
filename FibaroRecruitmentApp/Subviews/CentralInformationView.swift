//
//  CentralInformationLabel.swift
//  FibaroRecruitmentApp
//
//  Created by Dominika Czarnecka on 22.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit

class CentralInformationView: BaseView {

    let serialNumberLabel = UILabel()
    let macAdressLabel = UILabel()
    let softVersionLabel = UILabel()
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        
        serialNumberLabel.textColor = .white
        serialNumberLabel.textAlignment = .center
        addSubview(serialNumberLabel)
        
        macAdressLabel.textColor = .white
        macAdressLabel.adjustsFontSizeToFitWidth = true
        macAdressLabel.textAlignment = .left
        addSubview(macAdressLabel)
        
        softVersionLabel.textColor = .white
        softVersionLabel.adjustsFontSizeToFitWidth = true
        softVersionLabel.textAlignment = .right
        addSubview(softVersionLabel)
        
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        translatesAutoresizingMaskIntoConstraints = false
        serialNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        macAdressLabel.translatesAutoresizingMaskIntoConstraints = false
        softVersionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            serialNumberLabel.topAnchor.constraint(equalTo: topAnchor),
            serialNumberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            serialNumberLabel.widthAnchor.constraint(equalTo: widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            macAdressLabel.topAnchor.constraint(equalTo: serialNumberLabel.bottomAnchor),
            macAdressLabel.leftAnchor.constraint(equalTo: leftAnchor),
            macAdressLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
        ])
        
        NSLayoutConstraint.activate([
            softVersionLabel.topAnchor.constraint(equalTo: macAdressLabel.topAnchor),
            softVersionLabel.rightAnchor.constraint(equalTo: rightAnchor),
            softVersionLabel.widthAnchor.constraint(equalTo: macAdressLabel.widthAnchor),
            softVersionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }

}
