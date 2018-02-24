//
//  DevicesViewController.swift
//  FibaroRecruitmentApp
//
//  Created by Dominika Czarnecka on 24.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RoomViewController: BaseViewController {

    let devicesTableView = UITableView()
    private var cellIndentifier = "deviceCell"
    private var roomID: Int?
    
    init(_ room: RoomObject) {
        super.init(nibName: nil, bundle: nil)
        
        title = room.name
        roomID = room.id
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureSubViews() {
        
        devicesTableView.delegate = self
        devicesTableView.estimatedRowHeight = UITableViewAutomaticDimension
        devicesTableView.register(DeviceTableViewCell.self, forCellReuseIdentifier: cellIndentifier)
        view.addSubview(devicesTableView)
        
    }
    
    override func configureConstraints() {
        
        devicesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            devicesTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: .margin),
            devicesTableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -.margin * 2),
            devicesTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            devicesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRoomsFromServer()
    }
    
    private func getRoomsFromServer() {
        
        guard let apiManager = (UIApplication.shared.delegate as? AppDelegate)?.apiManager else { return }
        
        let rooms: Observable<[DeviceObject]> = apiManager.send(apiRequest: DeviceRequest())
        
        rooms
            .map({ (items) -> [DeviceObject] in
                return items
                    .filter({
                        return ($0.roomID == self.roomID) && $0.type != .unknown
                    })
                    .sorted(by: { $0.id ?? 0 < $1.id ?? 0 })
            })
            .bind(to: devicesTableView.rx.items(cellIdentifier: cellIndentifier)) {
                index, device, cell in
                (cell as? DeviceTableViewCell)?.nameLabel.text = device.name
                (cell as? DeviceTableViewCell)?.turnSwitch.isOn = device.properties?.value != 0
                
                if device.type == .dimmableLight {
                    (cell as? DeviceTableViewCell)?.dimmSlider.setValue(Float(device.properties?.value ?? 0), animated: true)
                } else {
                    (cell as? DeviceTableViewCell)?.dimmSlider.isHidden = true
                }
                
            }
            .disposed(by: disposeBag)
    }

}

extension RoomViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
