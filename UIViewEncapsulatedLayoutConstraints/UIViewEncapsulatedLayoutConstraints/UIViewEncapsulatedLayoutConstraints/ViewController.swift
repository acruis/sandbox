//
//  ViewController.swift
//  UIViewEncapsulatedLayoutConstraints
//
//  Created by Nguyen Quoc Dat on 20/6/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var childView: UIView = {
        let childView = UIView(frame: CGRect.zero)
        childView.backgroundColor = .green
        childView.translatesAutoresizingMaskIntoConstraints = false
        return childView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .purple
        
        self.view.addSubview(self.childView)
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint(item: self.childView,
                           attribute: NSLayoutAttribute.top,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: self.view,
                           attribute: NSLayoutAttribute.top,
                           multiplier: 1,
                           constant: 100).isActive = true

        NSLayoutConstraint(item: self.childView,
                           attribute: NSLayoutAttribute.leading,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: self.view,
                           attribute: NSLayoutAttribute.leading,
                           multiplier: 1,
                           constant: 0).isActive = true

        NSLayoutConstraint(item: self.childView,
                           attribute: NSLayoutAttribute.trailing,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: self.view,
                           attribute: NSLayoutAttribute.trailing,
                           multiplier: 1,
                           constant: 0).isActive = true
    }

}

