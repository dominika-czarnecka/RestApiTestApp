//
//  SectionTableViewCell.swift
//  FibaroRecruitmentApp
//
//  Created by Dominika Czarnecka on 24.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit

class SectionTableViewCell: BaseTableViewCell {

    let nameLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureSubviews() {
        super.configureSubviews()
        
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameLabel.textColor = .mainGray
        mainSubview.addSubview(nameLabel)
        
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: mainSubview.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: mainSubview.topAnchor, constant: .margin * 2),
            nameLabel.bottomAnchor.constraint(equalTo: mainSubview.bottomAnchor, constant: -.margin * 2),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        
    }
    
}
