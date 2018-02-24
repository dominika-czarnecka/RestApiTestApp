//
//  ViewController.swift
//  FibaroRecruitmentApp
//
//  Created by Dominika Czarnecka on 22.02.2018.
//  Copyright © 2018 Dominika Czarnecka. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: BaseViewController {

    let centralInformationView = CentralInformationView()
    let sectionsTableView = UITableView()
    private var cellIndentifier = "sectionCell"

    private let apiManager = ApiManager()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCentralFromServer()
        getSectionsFromServer()
    }

    override func configureSubViews() {
        
        centralInformationView.sizeToFit()
        view.addSubview(centralInformationView)
        
        sectionsTableView.register(SectionTableViewCell.self, forCellReuseIdentifier: cellIndentifier)
        view.addSubview(sectionsTableView)
        
    }
    
    override func configureConstraints() {
        
        sectionsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            centralInformationView.topAnchor.constraint(equalTo: view.topAnchor, constant: .margin),
            centralInformationView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            centralInformationView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            sectionsTableView.topAnchor.constraint(equalTo: centralInformationView.bottomAnchor, constant: .margin),
            sectionsTableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -.margin * 2),
            sectionsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sectionsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func getCentralFromServer() {

        let _ = apiManager.send(apiRequest: CentralRequest())
            .subscribe(onNext: { [weak self] (object) in
                DispatchQueue.main.async {
                    self?.centralInformationView.configure(object)
                }
            })
            .disposed(by: disposeBag)

    }
    
    private func getSectionsFromServer() {
        
        let sections: Observable<[SectionObject]> = apiManager.send(apiRequest: SectionRequest())
            
            sections
            .bind(to: sectionsTableView.rx.items(cellIdentifier: cellIndentifier)) {
                index, section, cell in
                (cell as? SectionTableViewCell)?.configure(section)
            }
            .disposed(by: disposeBag)
        
    }
    
}
