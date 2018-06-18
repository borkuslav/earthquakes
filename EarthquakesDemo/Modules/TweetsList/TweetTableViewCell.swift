//
//  TweetTableViewCell.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 17.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation
import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
 
    override func prepareForReuse() {
        self.userImageView.image = nil
        self.usernameLabel.text = nil
        self.tweetTextLabel.text = nil
        self.publishedDateLabel.text = nil
    }
}
