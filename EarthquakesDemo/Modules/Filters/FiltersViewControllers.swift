//
//  FiltersViewControllers.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 17.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation
import UIKit

protocol FiltersView: class {
    
    func reloadFiltersView()
}

class FiltersViewController: UITableViewController {
    
    var viewModel: FiltersViewModel!
    
    private let cellIdentifier = "filterCell"
    
    convenience init(viewModel: FiltersViewModel) {
        self.init(style: .grouped)
        self.viewModel = viewModel
        self.viewModel.filtersView = self
        self.title = viewModel.title()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForSection(section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = viewModel.titleForRow(inSection: indexPath.section, atIndex: indexPath.row)
        if viewModel.isSelected(item: indexPath.row, atSection: indexPath.section) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(item: indexPath.row, atSection: indexPath.section)
    }
}

extension FiltersViewController: FiltersView {
    
    func reloadFiltersView() {
        tableView.reloadData()
    }
}
