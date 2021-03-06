//
//  ViewAnimationControllerViewController.swift
//  animation-practice-ios
//
//  Created by TinhPV on 8/8/20.
//  Copyright © 2020 TinhPV. All rights reserved.
//

import UIKit

func delay(seconds: Double, completion: @escaping () -> Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

class ViewAnimationControllerViewController: UIViewController {
    
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var headingView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let spinner = UIActivityIndicatorView(style: .large)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        // setup the stage for animation
        headingView.center.x -= view.bounds.width
        headingView.alpha = 0.0
        
        usernameView.center.x -= view.bounds.width
        passwordView.center.x -= view.bounds.width
        
        proceedButton.center.y += 20
        proceedButton.alpha = 0.0
        
        logoImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        UIView.animate(withDuration: 1.0, animations: {
//            self.headingView.center.x += self.view.bounds.width
//        }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
            self.headingView.center.x += self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 1.1, animations: {
            self.headingView.alpha = 1.0
        }, completion: nil)
        
    
        
        // username's view animation
        UIView.animate(withDuration: 1.0, delay: 0.4, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
            self.usernameView.center.x += self.view.bounds.width
        }, completion: nil)
        
        
        // password's view animation
        UIView.animate(withDuration: 1.0, delay: 0.6, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
            self.passwordView.center.x += self.view.bounds.width
        }, completion: nil)
        
        // proceed button animation
        UIView.animate(withDuration: 0.8, delay: 0.7, options: [], animations: {
            self.proceedButton.center.y -= 20
            self.proceedButton.alpha = 1.0
        }, completion: nil)
        
        
        // logo animation
//        UIView.animate(withDuration: 1.0, delay: 0.5, options: [], animations: {
//            self.logoImageView.transform = .identity
//        }, completion: nil)
        
        
        var transformRotation = CATransform3DIdentity
        transformRotation.m34 = -1.0 / 1000
        transformRotation = CATransform3DRotate(transformRotation, .pi / 2, 0.0, 1.0, 0.0)

        let anim = CABasicAnimation(keyPath: "transform")
        anim.fromValue = NSValue(caTransform3D: transformRotation)
        anim.toValue = NSValue(caTransform3D: CATransform3DIdentity)
        anim.duration = 2.0
        anim.autoreverses = true
        anim.repeatCount = .infinity
        
        logoImageView.layer.add(anim, forKey: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        polishUI()
    }
    
    fileprivate func polishUI() {
        usernameView.layer.cornerRadius = 10.0
        passwordView.layer.cornerRadius = 10.0
        proceedButton.layer.cornerRadius = 10.0
        
        usernameView.layer.borderWidth = 0.0
        passwordView.layer.borderWidth = 0.0
        usernameView.layer.borderColor = #colorLiteral(red: 0.2666666667, green: 0.8431372549, blue: 0.7137254902, alpha: 1)
        passwordView.layer.borderColor = #colorLiteral(red: 0.2666666667, green: 0.8431372549, blue: 0.7137254902, alpha: 1)
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        proceedButton.addSubview(spinner)
    }
    
    
    @IBAction func handleProceed(_ sender: UIButton) {
        view.endEditing(true)
        
        UIView.animate(withDuration: 0.75, animations: {
            self.spinner.center = CGPoint(x: 40.0, y: self.proceedButton.frame.size.height/2)
            self.spinner.alpha = 1.0
        }, completion: nil)
        
        delay(seconds: 2.0) {
            let vc = self.storyboard?.instantiateViewController(identifier: "planevc") as! PlaneScheduleViewController
            self.present(vc, animated: true, completion: nil)
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}


extension ViewAnimationControllerViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let tag = textField.tag
        
        let animateBorder = CABasicAnimation(keyPath: "borderWidth")
        animateBorder.fromValue = 0.0
        animateBorder.toValue = 1.0
        animateBorder.fillMode = CAMediaTimingFillMode.both
        animateBorder.isRemovedOnCompletion = false
        animateBorder.duration = 0.8
        
        if tag == 0 {
            usernameView.layer.add(animateBorder, forKey: nil)
            passwordView.layer.removeAllAnimations()
        } else {
            passwordView.layer.add(animateBorder, forKey: nil)
            usernameView.layer.removeAllAnimations()
        }
    }
}
