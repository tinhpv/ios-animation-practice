//
//  PlaneScheduleViewController.swift
//  animation-practice-ios
//
//  Created by TinhPV on 8/9/20.
//  Copyright © 2020 TinhPV. All rights reserved.
//

import UIKit

enum AnimationDirection: Int {
    case positive = 1
    case negative = -1
}

class PlaneScheduleViewController: UIViewController {
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var flightNrView: UIView!
    @IBOutlet weak var gateNrView: UIView!
    @IBOutlet weak var flightLabel: UILabel!
    @IBOutlet weak var gateLabel: UILabel!
    @IBOutlet weak var depLabel: UILabel!
    @IBOutlet weak var arrLabel: UILabel!
    @IBOutlet weak var planeImage: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        changeFlight(to: londonToParis)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        statusView.layer.cornerRadius = 10.0
        flightNrView.layer.cornerRadius = 10.0
        gateNrView.layer.cornerRadius = 10.0
    }
    
    
    private func changeFlight(to data: FlightData) {
        summaryLabel.text = data.summary
    
        
        // animate plane
        animatePlane()
        
        // animate flight - gate info
        let direction: AnimationDirection = data.isTakingOff ? .positive : .negative
        doCubeTransition(label: flightLabel, text: data.flightNr, direction: direction)
        doCubeTransition(label: gateLabel, text: data.gateNr, direction: direction)
        
        
        // animate departing - arriving place
        let offsetDeparting = CGPoint(x: CGFloat(direction.rawValue * 80), y: 0.0)
        moveLabel(label: depLabel, text: data.departingFrom, offset: offsetDeparting)
        
        let offsetArriving = CGPoint( x: 0.0, y: CGFloat(direction.rawValue * 50))
        moveLabel(label: arrLabel, text: data.arrivingTo, offset: offsetArriving)
        
        
        // animate status banner
        moveBanner(label: statusLabel, text: data.flightStatus)
        
        // animate summary
        summarySwitch(to: data.summary)

        
        delay(seconds: 3.0) {
            self.changeFlight(to: data.isTakingOff ? parisToRome : londonToParis)
        }
    }
    
    
    private func summarySwitch(to label: String) {
        UIView.transition(with: summaryLabel, duration: 1.5, options: .transitionFlipFromBottom, animations: {
            self.summaryLabel.text = label
        }, completion: nil)
    }
    
    
    
    private func moveBanner(label: UILabel, text: String) {
        UIView.transition(with: label, duration: 0.8, options: .transitionFlipFromTop, animations: {
            label.text = text
        }, completion: nil)
        
//        let auxLabel = UILabel(frame: label.frame)
//        auxLabel.text = text
//        auxLabel.font = label.font
//        auxLabel.textAlignment = label.textAlignment
//        auxLabel.textColor = label.textColor
//        auxLabel.backgroundColor = .clear
//
//        let offset = CGFloat(1) * label.frame.size.height / 2
//        auxLabel.transform = CGAffineTransform(translationX: 0, y: offset).scaledBy(x: 1.0, y: 0.1)
//
//        label.superview?.addSubview(auxLabel)
//
//        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
//            auxLabel.transform = .identity
//            label.transform = CGAffineTransform(translationX: 0, y: -offset).scaledBy(x: 1.0, y: 0.1)
//        }) { (_) in
//            label.transform = .identity
//            label.text = text
//            auxLabel.removeFromSuperview()
//        }
    }
    
    private func doCubeTransition(label: UILabel, text: String, direction: AnimationDirection) {
        
        // the extra label
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
//        auxLabel.backgroundColor = label.backgroundColor
        
        // change the transform to be scaled vertically 10%
        let auxLabelOffset = CGFloat(direction.rawValue) * label.frame.size.height / 2.0
        auxLabel.transform = CGAffineTransform(translationX: 0.0, y: auxLabelOffset).scaledBy(x: 1.0, y: 0.1)
        label.superview?.addSubview(auxLabel)
        
        UIView.animate(withDuration: 0.7, delay: 0.0, options: [.curveEaseOut], animations: {
            label.alpha = 0.0
            auxLabel.transform = .identity
        }) { (_) in
            label.alpha = 1.0
            label.text = text
            auxLabel.removeFromSuperview()
        }
    }
    
    
    private func moveLabel(label: UILabel, text: String, offset: CGPoint) {
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        auxLabel.backgroundColor = .clear
        auxLabel.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        auxLabel.alpha = 0
        view.addSubview(auxLabel)
        
        // fading out the original label
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
//            label.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
            label.alpha = 0.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            auxLabel.transform = .identity
            auxLabel.alpha = 1.0
        }) { (_) in
            auxLabel.removeFromSuperview()
            label.text = text
            label.alpha = 1.0
            label.transform = .identity
        }
    }
    
    private func animatePlane() {
        let originalCenter = planeImage.center
        
        UIView.animateKeyframes(withDuration: 1.2, delay: 0.0, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                self.planeImage.center.x += 50
                self.planeImage.center.y -= 10
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4) {
                self.planeImage.transform = CGAffineTransform(rotationAngle: -.pi / 8)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
              self.planeImage.center.x += 100.0
              self.planeImage.center.y -= 50.0
              self.planeImage.alpha = 0.0
            }
              
            UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01) {
              self.planeImage.transform = .identity
              self.planeImage.center = CGPoint(x: 0.0, y: originalCenter.y)
            }
              
            UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45) {
              self.planeImage.alpha = 1.0
              self.planeImage.center = originalCenter
            }
    
        }, completion: nil)
    }


}

