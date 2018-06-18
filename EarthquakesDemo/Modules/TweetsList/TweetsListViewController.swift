//
//  TweetsViewController.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 17.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol TweetsListView: class {
  
    func reloadList()
    func reloadHeader()
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

class TweetsListViewController: UIViewController {
    
    private var viewModel: TweetsListViewModel!
    
    private let tweetCellIdentifier = "tweetCell"
    
    private var tableView: UITableView!
    private var headerView: TweetsListHeaderView!
    
    convenience init(viewModel: TweetsListViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.tweetsList = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.resizeToFitSuperview()
        tableView.delegate = self
        tableView.dataSource = self
        
        let headerView = createSliderView()
        tableView.tableHeaderView = headerView
        self.headerView = headerView
        tableView.register(
            UINib(nibName: "TweetTableViewCell", bundle: nil),
            forCellReuseIdentifier: tweetCellIdentifier)
        viewModel.fetchTweets()
    }
}

extension TweetsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tweetCellIdentifier) as? TweetTableViewCell else {
            return UITableViewCell()
        }
        
        let tweetViewModel = viewModel.tweetViewModel(forIndex: indexPath.row)
        cell.usernameLabel.text = tweetViewModel.username()
        cell.tweetTextLabel.text = tweetViewModel.text()
        cell.publishedDateLabel.text = tweetViewModel.date()
        if let imageUrlString = tweetViewModel.userImageUrl(), let url = URL(string: imageUrlString) {
            cell.userImageView.kf.setImage(with: url, placeholder: UIImage(named: "user")) { (image, error, cache, url) in
              
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func createSliderView() -> TweetsListHeaderView {
        let headerView: TweetsListHeaderView = UIView.fromNib()
        headerView.titleLabel.text = viewModel.radiusTitle()
        headerView.slider.minimumValue = 10        
        headerView.slider.maximumValue = 1000
        headerView.slider.value = viewModel.getRadius()
        headerView.slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        headerView.slider.addTarget(self, action: #selector(sliderFinished(_:)), for: .touchUpInside)
        return headerView
    }
    
    @objc private func sliderValueChanged(_ slider: UISlider){
        viewModel.updateRadius(radius: slider.value)
    }
    
    @objc private func sliderFinished(_ slider: UISlider){
        viewModel.sliderDidFinish()
    }
}

extension TweetsListViewController: TweetsListView {
    
    func reloadList() {        
        tableView.reloadData()
    }
    
    func reloadHeader() {
        headerView.titleLabel.text = viewModel.radiusTitle()
    }
    
    func showLoadingIndicator() {
        self.view.showLoadingIndicator()
    }
    
    func hideLoadingIndicator() {
        self.view.hideLoadingIndicator()
    }
    
}
