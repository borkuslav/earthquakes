//
//  NSLayoutConstraint+Extensions.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 16.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    
    func withPriority(priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
    
    func activate() -> NSLayoutConstraint {
        self.isActive = true
        return self
    }
}
