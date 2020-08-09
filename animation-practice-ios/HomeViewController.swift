//
//  HomeViewController.swift
//  animation-practice-ios
//
//  Created by TinhPV on 8/8/20.
//  Copyright © 2020 TinhPV. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func viewAnimationPressed(_ sender: UIButton) {
        let viewAnimationVC = self.storyboard?.instantiateViewController(withIdentifier: "viewAnimationVC") as! ViewAnimationControllerViewController
        self.navigationController?.pushViewController(viewAnimationVC, animated: true)
    }

}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
