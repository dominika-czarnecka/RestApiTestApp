//
//  DeviceTableViewCell.swift
//  FibaroRecruitmentApp
//
//  Created by Dominika Czarnecka on 24.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DeviceTableViewCell: BaseTableViewCell {

    let nameLabel = UILabel()
    let turnSwitch = UISwitch()
    let dimmSlider = UISlider()
    let stateLabel = UILabel()
    
    var onSliderValueChanged: ((Float) -> ())?
    var onSwichValueChanged: ((Bool) -> ())?
    
    private let disposeBag = DisposeBag()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bind()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        
        nameLabel.textColor = .mainGray
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        mainSubview.addSubview(nameLabel)
        
        turnSwitch.onTintColor = .mainBlue
        mainSubview.addSubview(turnSwitch)
        
        dimmSlider.minimumValueImage = #imageLiteral(resourceName: "light-bulb-off")
        dimmSlider.maximumValueImage = #imageLiteral(resourceName: "light-bulb-on")
        dimmSlider.minimumTrackTintColor = .mainBlue
        dimmSlider.maximumValue = 100
        dimmSlider.minimumValue = 0
        mainSubview.addSubview(dimmSlider)
        
        stateLabel.textColor = .red
        mainSubview.addSubview(stateLabel)
        
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        turnSwitch.translatesAutoresizingMaskIntoConstraints = false
        dimmSlider.translatesAutoresizingMaskIntoConstraints = false
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: mainSubview.leftAnchor, constant: .margin),
            nameLabel.centerYAnchor.constraint(equalTo: turnSwitch.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            turnSwitch.rightAnchor.constraint(equalTo: mainSubview.rightAnchor, constant: -.margin),
            turnSwitch.topAnchor.constraint(equalTo: mainSubview.topAnchor, constant: .margin)
        ])
        
        NSLayoutConstraint.activate([
            dimmSlider.centerXAnchor.constraint(equalTo: mainSubview.centerXAnchor),
            dimmSlider.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .margin),
            dimmSlider.bottomAnchor.constraint(equalTo: mainSubview.bottomAnchor, constant: -.margin),
            dimmSlider.widthAnchor.constraint(equalTo: mainSubview.widthAnchor, multiplier: 0.6)
        ])
        
        NSLayoutConstraint.activate([
            stateLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: .margin),
            stateLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
            ])
        
    }
    
    func bind() {
        
        dimmSlider.rx.value
            .distinctUntilChanged()
            .do(onNext: { [weak self] (value) in
                self?.turnSwitch.setOn(value != 0, animated: true)
            })
            .throttle(1, latest: true, scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (value) in
                self?.onSliderValueChanged?(value)
            })
            .disposed(by: disposeBag)
        
        turnSwitch.rx.value
            .do(onNext: { [weak self] (isOn) in
                self?.dimmSlider.setValue(isOn ? 100 : 0, animated: true)
            })
            .throttle(1, latest: true, scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (isOn) in
                self?.onSwichValueChanged?(isOn)
            })
            .disposed(by: disposeBag)
        
    }
    
}
