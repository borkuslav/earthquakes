//
//  TweetsViewController.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 17.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation
import UIKit

class TweetsListViewController: UITableViewController {
    
    private var viewModel: TweetsListViewModel!
    
    convenience init(viewModel: TweetsListViewModel) {
        self.init(style: .plain)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchTweets()
    }
    
}
