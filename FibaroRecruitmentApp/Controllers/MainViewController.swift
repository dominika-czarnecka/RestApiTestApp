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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCentral()
        loadSections()
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
    
    override func bind() {
        
        sectionsTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] (indexPath) in
                self?.sectionsTableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
        
        sectionsTableView.rx.modelSelected(SectionObject.self)
            .subscribe(onNext: { (section) in
                self.navigationController?.pushViewController(SectionViewController(section), animated: true)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func loadCentral() {

        guard let apiManager = (UIApplication.shared.delegate as? AppDelegate)?.apiManager else { return }
        
        let object: Observable<CentralObject> = apiManager.send(apiRequest: CentralRequest())
            
        object
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (object) in
                self?.centralInformationView.serialNumberLabel.text = "\("CentralInformationView.Label.Text.SerialNumber".localized) \(object.serialNumber ?? "")"
                self?.centralInformationView.softVersionLabel.text = "\("CentralInformationView.Label.Text.SoftVersio".localized) \(object.softVersion ?? "")"
                self?.centralInformationView.macAdressLabel.text = "\("CentralInformationView.Label.Text.MacAdress".localized) \(object.mac ?? "")"
                }, onError: { [weak self] (error) in
                    let alert = UIAlertController.createWithOKAction("Error", message: error.localizedDescription)
                    self?.present(alert, animated: true, completion: nil)
                    return
            })
            .disposed(by: disposeBag)

    }
    
    private func loadSections() {

        guard let apiManager = (UIApplication.shared.delegate as? AppDelegate)?.apiManager else { return }
        
        let sections: Observable<[SectionObject]> = apiManager.send(apiRequest: SectionRequest())
        
        sections
            .map({ (items) -> [SectionObject] in
                return items.sorted(by: { $0.id ?? 0 < $1.id ?? 0 })
            })
            .bind(to: sectionsTableView.rx.items(cellIdentifier: cellIndentifier)) {
                index, section, cell in
                (cell as? SectionTableViewCell)?.nameLabel.text = section.name
            }
            .disposed(by: disposeBag)
        
    }
    
}
