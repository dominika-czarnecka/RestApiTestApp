//
//  SectionTableViewCell.swift
//  FibaroRecruitmentApp
//
//  Created by Dominika Czarnecka on 24.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit

class SectionTableViewCell: BaseTableViewCell {

    private let mainSubview = UIView()
    private let nameLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureSubviews() {
        
        mainSubview.backgroundColor = .white
        mainSubview.layer.cornerRadius = .cornerRadious
        addSubview(mainSubview)
        
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.textColor = .gray
        addSubview(nameLabel)
        
    }
    
    override func configureConstraints() {
        
        mainSubview.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainSubview.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainSubview.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainSubview.heightAnchor.constraint(equalTo: heightAnchor, constant: -.margin * 2),
            mainSubview.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: mainSubview.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: mainSubview.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalTo: heightAnchor),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        
    }
    
    func configure(_ object: SectionObject) {
        nameLabel.text = object.name
    }
    
}
