//
//  ViewController.swift
//  TabBarInsideNavigationController
//
//  Created by Nguyen Quoc Dat on 26/3/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pushButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pushButton.layer.cornerRadius = 6
    }

    @IBAction func didPushButton(_ sender: UIButton) {
        let msb = UIStoryboard(name: "Main", bundle: nil)
        let newVC = msb.instantiateViewController(withIdentifier: "nvc")
        newVC.title = "Yellow"
        newVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(newVC, animated: true)
    }
}
