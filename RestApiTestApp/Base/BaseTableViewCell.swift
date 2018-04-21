//
//  BaseTableViewCell.swift
//  RestApiTestApp
//
//  Created by Dominika Czarnecka on 24.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    internal let mainSubview = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .mainBlue
        configureSubviews()
        configureConstraints()
        selectionStyle = .none
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal func configureSubviews() {
        
        mainSubview.backgroundColor = .white
        mainSubview.layer.cornerRadius = .cornerRadious
        addSubview(mainSubview)
    }
    
    internal func configureConstraints() {
        
        mainSubview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainSubview.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainSubview.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainSubview.heightAnchor.constraint(equalTo: heightAnchor, constant: -.margin * 2),
            mainSubview.widthAnchor.constraint(equalTo: widthAnchor)
            ])
        
    }

}
