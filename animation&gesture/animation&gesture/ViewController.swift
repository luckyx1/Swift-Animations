//
//  ViewController.swift
//  animation&gesture
//
//  Created by Rob Hernandez on 3/15/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var upPosition: CGPoint!
    var downPosition: CGPoint!
    
    @IBOutlet weak var trayView: UIView!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceInitialCenter: CGPoint!

    var initialTrayCenter: CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        upPosition = trayView.center
        downPosition = CGPoint(x: trayView.center.x, y: trayView.center.y + 200)
    }


    @IBAction func onFaceDrag(sender: UIPanGestureRecognizer) {
        NSLog("I am being panned onFaceDrag")
        let translation = sender.translation(in: view)
        let imageView = sender.value(forKey: "view") as! UIImageView
        
        if sender.state == UIGestureRecognizerState.began {
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceInitialCenter = newlyCreatedFace.center
        } else if sender.state == UIGestureRecognizerState.changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceInitialCenter.x + translation.x, y: newlyCreatedFaceInitialCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.ended {
            
        }
    }

    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parentView
        let translation = sender.translation(in: self.trayView)
        
        NSLog("I am being panned on onPanGesture")

        if (sender.state == UIGestureRecognizerState.began) {
            initialTrayCenter = trayView.center
            
        } else if (sender.state == UIGestureRecognizerState.changed) {
            trayView.center = CGPoint(x: (self.initialTrayCenter?.x)!, y: (self.initialTrayCenter?.y)! + translation.y)
            
        } else if (sender.state == UIGestureRecognizerState.ended) {
            let velocity = sender.velocity(in: self.trayView)
            if velocity.y >= 0 {
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.trayView.center = self.downPosition
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.trayView.center = self.upPosition
                })
            }
        }
    }


}

