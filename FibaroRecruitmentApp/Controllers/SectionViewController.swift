//
//  SectionViewController.swift
//  FibaroRecruitmentApp
//
//  Created by Dominika Czarnecka on 24.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SectionViewController: BaseViewController {

    let roomsTableView = UITableView()
    private var cellIndentifier = "roomCell"
    private var sectionID: Int?
    
    init(_ section: SectionObject) {
        super.init(nibName: nil, bundle: nil)
        
        title = section.name
        sectionID = section.id
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureSubViews() {
        roomsTableView.register(SectionTableViewCell.self, forCellReuseIdentifier: cellIndentifier)
        view.addSubview(roomsTableView)
    }
    
    override func configureConstraints() {
        
        roomsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            roomsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: .margin),
            roomsTableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -.margin * 2),
            roomsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roomsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    override func bind() {
        
        roomsTableView.rx.modelSelected(RoomObject.self)
            .subscribe(onNext: { (room) in
                self.navigationController?.pushViewController(RoomViewController(room), animated: true)
            })
            .disposed(by: disposeBag)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getRoomsFromServer()
    }

    private func getRoomsFromServer() {
        
        guard let apiManager = (UIApplication.shared.delegate as? AppDelegate)?.apiManager else { return }
        
        let rooms: Observable<[RoomObject]> = apiManager.send(apiRequest: RoomRequest())
        
        rooms
            .map({ (items) -> [RoomObject] in
                return items
                    .filter({ return $0.sectionID == self.sectionID })
                    .sorted(by: { $0.id ?? 0 < $1.id ?? 0 })
            })
            .bind(to: roomsTableView.rx.items(cellIdentifier: cellIndentifier)) {
                index, room, cell in
                (cell as? SectionTableViewCell)?.nameLabel.text = room.name
            }
            .disposed(by: disposeBag)
    }
    
}
