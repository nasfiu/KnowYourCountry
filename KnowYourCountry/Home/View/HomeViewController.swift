//
//  HomeViewController.swift
//  KnowYourCountry
//
//  Created by Nasfi on 05/02/21.
//

import RxSwift
import UIKit

final class HomeViewController: UIViewController, ErrorAlertProtocol {
    
    private let countryInfoTableView = UITableView(frame: .zero, style: .grouped)
    private let countryInfoCellIdentifier = "CountryDetailCellIdentifier"
    private let viewModel = CountryInfoViewModel()
    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    private var spinner = UIActivityIndicatorView()
    private let estimatedRowHeight: CGFloat = 400
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getCountryInfo()
        setupPullToRefresh()
        setupActivityIndicator()
    }
}

// MARK: UITableViewDataSource Methods

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countryInfoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: countryInfoCellIdentifier, for: indexPath) as? CountryInfoTableViewCell else {
            return CountryInfoTableViewCell(style: .default, reuseIdentifier: countryInfoCellIdentifier)
        }
        if let countryInfoItem = viewModel.countryInfoList?[indexPath.row] {
            cell.updateCellUI(countryInfoItem: countryInfoItem)
        }
        return cell
    }
}

// MARK: UITableViewDelegate Methods

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        CGFloat.leastNormalMagnitude
    }
}

private extension HomeViewController {
    
    // MARK: SetupUI Custom methods
    
    func setupTableView() {
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
    
    func setupLayout() {
        countryInfoTableView.translatesAutoresizingMaskIntoConstraints = false
        countryInfoTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutConstants.verticalMargin).isActive = true
        countryInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        countryInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        countryInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func registerTableViewCell() {
        countryInfoTableView.register(CountryInfoTableViewCell.self, forCellReuseIdentifier: countryInfoCellIdentifier)
    }
    
    func setupPullToRefresh() {
        refreshControl.addTarget(self, action: #selector(getCountryInfo), for: .valueChanged)
        countryInfoTableView.refreshControl = refreshControl
    }
    
    func setupActivityIndicator() {
        if #available(iOS 13.0, *) {
            spinner.style = .large
        }
        else {
            spinner.style = .whiteLarge
        }
        spinner.center = view.center
        self.view.addSubview(spinner)
    }
    
    func setupNavigationBar(title: String) {
        navigationItem.title = title
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.setupNavigationBar(title: self.viewModel.title ?? "")
            self.countryInfoTableView.reloadData()
        }
    }
    
    func endRefreshing() {
        if spinner.isAnimating {
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
            }
        }
        if let refreshContrl = countryInfoTableView.refreshControl {
            if refreshContrl.isRefreshing {
                DispatchQueue.main.async {
                    refreshContrl.endRefreshing()
                }
            }
        }
    }
    
    // MARK: - API Call
    
    @objc func getCountryInfo() {
        viewModel.getCountryInfoDetails()
            .observeOn(MainScheduler.instance)
            .do(onSubscribe: {[unowned self] in
                if !self.refreshControl.isRefreshing {
                    self.spinner.startAnimating()
                }
            }, onDispose: {
                self.endRefreshing()
            })
            .subscribe(onSuccess: {
                self.updateUI()
            }, onError: {error in
                self.endRefreshing()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showAlert(message: error.localizedDescription)
                }
            })
            .disposed(by: disposeBag)
    }
}
