//
//  HomeViewController.swift
//  KnowYourCountry
//
//  Created by Nasfi on 05/02/21.
//

import UIKit

class HomeViewController: UIViewController {

    private let countryInfoTableView = UITableView(frame: .zero, style: .grouped)
    private let countryInfoCellIdentifier = "CountryDetailCellIdentifier"
    private let estimatedRowHeight:CGFloat = 400

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(countryInfoTableView)
        countryInfoTableView.separatorStyle = .none
        countryInfoTableView.showsVerticalScrollIndicator = false
        countryInfoTableView.sectionHeaderHeight = CGFloat.leastNonzeroMagnitude
        countryInfoTableView.rowHeight = UITableView.automaticDimension
        countryInfoTableView.estimatedRowHeight = estimatedRowHeight
        countryInfoTableView.dataSource = self
        countryInfoTableView.delegate = self
        setupLayout()
        registerTableViewCell()
    }
    
    private func setupLayout() {
        countryInfoTableView.translatesAutoresizingMaskIntoConstraints = false
        countryInfoTableView.topAnchor.constraint(equalTo: view.topAnchor,constant: LayoutConstants.verticalMargin).isActive = true
        countryInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        countryInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        countryInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func registerTableViewCell(){
        countryInfoTableView.register(CountryInfoTableViewCell.self, forCellReuseIdentifier: countryInfoCellIdentifier)
    }

}

//MARK:- UITableViewDataSource Methods

extension HomeViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: countryInfoCellIdentifier, for: indexPath) as! CountryInfoTableViewCell
        cell.updateCellUI()
        return cell
    }
}

//MARK:- UITableViewDelegate Methods

extension HomeViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
