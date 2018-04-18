//
//  ViewController.swift
//  PresentAndPushVCs
//
//  Created by Nguyen Quoc Dat on 23/3/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func pushButton(_ sender: UIButton) {
        let msb = UIStoryboard(name: "Main", bundle: nil)
        let vc = msb.instantiateViewController(withIdentifier: "NewVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func presentButton(_ sender: UIButton) {
        let msb = UIStoryboard(name: "Main", bundle: nil)
        let vc = msb.instantiateViewController(withIdentifier: "NewVC")
        self.present(vc, animated: true)
    }
}

