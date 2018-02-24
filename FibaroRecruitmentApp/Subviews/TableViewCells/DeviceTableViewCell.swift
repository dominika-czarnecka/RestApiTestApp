//
//  DeviceTableViewCell.swift
//  FibaroRecruitmentApp
//
//  Created by Dominika Czarnecka on 24.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit

class DeviceTableViewCell: BaseTableViewCell {

    let nameLabel = UILabel()
    let turnSwitch = UISwitch()
    let dimmSlider = UISlider()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureSubviews() {
        
        nameLabel.textColor = .gray
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        addSubview(nameLabel)
        
        addSubview(turnSwitch)
        
        dimmSlider.maximumValue = 100
        dimmSlider.minimumValue = 0
        addSubview(dimmSlider)
        
    }
    
    override func configureConstraints() {
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        turnSwitch.translatesAutoresizingMaskIntoConstraints = false
        dimmSlider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: .margin),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: .margin),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -.margin)
        ])
        
        NSLayoutConstraint.activate([
            turnSwitch.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            turnSwitch.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dimmSlider.centerXAnchor.constraint(equalTo: centerXAnchor),
            dimmSlider.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .margin),
            dimmSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.margin),
            dimmSlider.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6)
        ])
        
    }
    
}
