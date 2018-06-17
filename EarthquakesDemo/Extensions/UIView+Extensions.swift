//
//  UIViewController+Extensions.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 17.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation
import UIKit


private class LoadingIndicatorBackgroundView: UIView {
    
}

extension UIView {
    
    func resizeToFitSuperview() {
        guard let superview = self.superview else {
            return
        }
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: superview.widthAnchor).withPriority(priority: .defaultHigh),
            self.heightAnchor.constraint(equalTo: superview.heightAnchor).withPriority(priority: .defaultHigh),
            self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).withPriority(priority: .defaultHigh),
            self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).withPriority(priority: .defaultHigh),
        ])
    }
    
    func showLoadingIndicator() {
        
        let backgroundView = LoadingIndicatorBackgroundView(frame: self.bounds)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor.white
        self.addSubview(backgroundView)
        backgroundView.resizeToFitSuperview()
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
        indicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        self.subviews.first(where: { subview in
            return subview is LoadingIndicatorBackgroundView
        })?.removeFromSuperview()
    }
    
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
}
