//
//  BaseTableViewCell.swift
//  FibaroRecruitmentApp
//
//  Created by Dominika Czarnecka on 24.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
        configureConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal func configureSubviews() { }
    
    internal func configureConstraints() { }
    
}
