//
//  NewVC.swift
//  PresentAndPushVCs
//
//  Created by Nguyen Quoc Dat on 23/3/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

class NewVC: UIViewController {
    @IBAction func popButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func pushButton(_ sender: UIButton) {
        let msb = UIStoryboard(name: "Main", bundle: nil)
        let vc = msb.instantiateViewController(withIdentifier: "NewVC")
        let rvc = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
        rvc?.pushViewController(vc, animated: true)
    }
    
    @IBAction func presentButton(_ sender: UIButton) {
        let msb = UIStoryboard(name: "Main", bundle: nil)
        let vc = msb.instantiateViewController(withIdentifier: "NewVC")
        self.present(vc, animated: true)
    }
}
