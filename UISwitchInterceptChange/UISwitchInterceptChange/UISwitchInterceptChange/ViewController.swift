//
//  ViewController.swift
//  UISwitchInterceptChange
//
//  Created by Nguyen Quoc Dat on 23/9/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let theSwitch: UISwitch = UISwitch(frame: CGRect(x: 100, y: 50, width: 0, height: 0))

    private let scrollViewSwitch: UISwitch = UISwitch(frame: .zero)

    private let scrollView: UIScrollView
        = UIScrollView(frame: CGRect(x: 50, y: 100, width: 300, height: 500))

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(theSwitch)
        self.view.addSubview(scrollView)
        scrollView.delaysContentTouches = false
        scrollView.bounces = true

        scrollView.contentSize = CGSize(width: 300, height: 501)
        scrollView.addSubview(scrollViewSwitch)

        theSwitch.addTarget(self, action: #selector(didToggleSwitch), for: .valueChanged)
        scrollViewSwitch.addTarget(self, action: #selector(didToggleSwitch), for: .valueChanged)
    }

    @objc private func didToggleSwitch(sender: UISwitch) {
        // Necessary to do this in main thread.
        DispatchQueue.main.async {
            // Don't do this, the switch will still animate through before jankily switching back.
//            sender.isOn = !sender.isOn

            // Do this
            sender.setOn(!sender.isOn,
                         animated: true) // `false` is same as setting .isOn straight up.
        }
    }
}
