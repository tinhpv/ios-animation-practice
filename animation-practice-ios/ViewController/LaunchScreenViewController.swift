//
//  LaunchScreenViewController.swift
//  animation-practice-ios
//
//  Created by TinhPV on 8/10/20.
//  Copyright © 2020 TinhPV. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    @IBOutlet weak var backgroundLogo: UIImageView!
    @IBOutlet weak var textCenter: UIImageView!
    @IBOutlet weak var redDot: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        textCenter.alpha = 0.0
        redDot.alpha = 0.0
        redDot.center.y -= 50
        
        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.fromValue = 0.0
        fadeIn.toValue = 1.0
        fadeIn.duration = 2.0
        
//        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        let rotation = CASpringAnimation(keyPath: "transform.rotation")
        rotation.fromValue = Double.pi
        rotation.toValue = 0
        rotation.damping = 5
        rotation.stiffness = 100
        rotation.mass = 0
        rotation.duration = rotation.settlingDuration
        
        backgroundLogo.layer.add(fadeIn, forKey: nil)
        textCenter.layer.add(fadeIn, forKey: nil)
        textCenter.layer.add(rotation, forKey: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.6, delay: 1.5, options: .transitionFlipFromTop, animations: {
            self.redDot.center.y += 50
            self.redDot.alpha = 1.0
        }, completion: nil)
        
        delay(seconds: 2.5) {
            let vc = self.storyboard?.instantiateViewController(identifier: "viewAnimationVC") as! ViewAnimationControllerViewController
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    

}
