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
    
    var devices = Variable<[DeviceObject]>([])
    
    init(_ room: RoomObject) {
        super.init(nibName: nil, bundle: nil)
        
        title = room.name
        roomID = room.id
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureSubViews() {
        
        devicesTableView.separatorStyle = .none
        devicesTableView.backgroundColor = .mainBlue
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
        loadDevices()
    }
    
    private func loadDevices() {
        
        guard let apiManager = (UIApplication.shared.delegate as? AppDelegate)?.apiManager else { return }
        
        Observable<Int>.interval(RxTimeInterval(floatLiteral: 10), scheduler: MainScheduler.instance).asObservable()
            .flatMap { _ -> Observable<[DeviceObject]> in
                return apiManager.send(apiRequest: DeviceRequest())
            }
            .bind(to: devices)
            .disposed(by: disposeBag)
        
        apiManager.send(apiRequest: DeviceRequest())
            .bind(to: devices)
            .disposed(by: disposeBag)
        
        devices
            .asObservable()
            .map({ (items) -> [DeviceObject] in
                return items
                    .filter({
                        return ($0.roomID == self.roomID) && $0.type != .unknown
                    })
                    .sorted(by: { $0.id < $1.id })
            })
            .bind(to: devicesTableView.rx.items(cellIdentifier: cellIndentifier)) {
                index, device, cell in
                
                guard let cell = cell as? DeviceTableViewCell else { return }
                
                cell.nameLabel.text = device.name
                cell.turnSwitch.isOn = device.properties?.value != 0
                cell.stateLabel.text = device.properties?.dead == true ? "Dead" : (device.properties?.disabled == true ? "Disabled" : "")
                
                if cell.stateLabel.text != "" {
                    cell.mainSubview.backgroundColor = .lightGray
                    cell.isUserInteractionEnabled = false
                }
                
                cell.onSwichValueChanged = ({ [weak self] (isOn: Bool) in
                    self?.onSwichValueChanged(device, isOn: isOn)
                })
                
                if device.type == .dimmableLight {
                    cell.dimmSlider.setValue(Float(device.properties?.value ?? 0), animated: true)
                    cell.onSliderValueChanged = ({ [weak self] (value: Float) in
                        self?.onSliderValueChanged(device, value: Double(value))
                    })
                } else {
                    cell.dimmSlider.isHidden = true
                }
                
            }
            .disposed(by: disposeBag)
    }
    
    func onSwichValueChanged(_ device: DeviceObject, isOn: Bool) {
        
        guard let apiManager = (UIApplication.shared.delegate as? AppDelegate)?.apiManager else { return }
        
        if let error = apiManager.sendWithoutResponse(apiRequest: TurnRequest(device.id, turnOn: isOn)) {
            let alert = UIAlertController.createWithOKAction("Error", message: error.localizedDescription)
            present(alert, animated: true, completion: nil)
            return
        }
        
    }
    
    func onSliderValueChanged(_ device: DeviceObject, value: Double) {
        
        guard let apiManager = (UIApplication.shared.delegate as? AppDelegate)?.apiManager else { return }
        
        if let error = apiManager.sendWithoutResponse(apiRequest: SetValueRequest(device.id, value: value)) {
            let alert = UIAlertController.createWithOKAction("Error", message: error.localizedDescription)
            present(alert, animated: true, completion: nil)
            return
            
        }

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
