//
//  ViewController.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 15.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import UIKit

protocol EarthquakesList: class {
    
    func reloadList()
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

class EarthquakesViewController: UIViewController {

    private var viewModel: EarthquakesViewModel!
    
    private var tableView: UITableView!
    private let earthquakeCellIdentifier = "earthquakeCell"
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.resizeToFitSuperview()
        tableView.register(
            UINib(nibName: "EarthquakeTableViewCell", bundle: nil),
            forCellReuseIdentifier: earthquakeCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        
        createViewModel()
        self.title = viewModel.title()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "filter"),
            style: .plain,
            target: self,
            action: #selector(filtersButtonPressed))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        self.createViewModel()
    }
    
    private func createViewModel() {
        self.viewModel = EarthquakesViewModel(
            earthquakesList: self,
            networkService: NetworkService())
    }
    
    @objc private func refreshList() {
        viewModel.onPullDownToRefresh()
    }
}

extension EarthquakesViewController: EarthquakesList {
    
    func reloadList() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func showLoadingIndicator() {
        self.view.showLoadingIndicator()
    }
    
    func hideLoadingIndicator() {
        self.view.hideLoadingIndicator()
    }
}

extension EarthquakesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let tweetsListViewModel = viewModel.createTweetsListViewModel(forRow: indexPath.row) {
            let tweetsListViewController = TweetsListViewController(viewModel: tweetsListViewModel)
            self.navigationController?.pushViewController(tweetsListViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension EarthquakesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: earthquakeCellIdentifier) as? EarthquakeTableViewCell else {
            return UITableViewCell()
        }
        
        let earthquakeViewModel = viewModel.earthquakeViewModel(forIndex: indexPath.row)
        cell.locationLabel.text = earthquakeViewModel.location
        cell.timeLabel.text = earthquakeViewModel.time
        cell.magnitudeLabel.text = earthquakeViewModel.magnitude
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    /*
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        view.widthAnchor.constraint(equalToConstant: tableView.frame.size.width).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20).withPriority(priority: .defaultHigh),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ])
        button.setTitle(viewModel.headerTitle(), for: .normal)
        button.setTitleColor(view.tintColor, for: .normal)
        button.titleLabel?.textAlignment = .right
        button.addTarget(self, action: #selector(filtersButtonPressed), for: .touchUpInside)
        return view
    }
     */
    
    @objc func filtersButtonPressed() {
        let filtersViewController = FiltersViewController(viewModel: viewModel.createFiltersViewModel())
        self.navigationController?.pushViewController(filtersViewController, animated: true)
    }
}

