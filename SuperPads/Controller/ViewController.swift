//
//  ViewController.swift
//  SuperPads
//
//  Created by Rodrigo Salles Stefani on 04/06/19.
//  Copyright © 2019 Rodrigo Salles Stefani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pad12: UIImageView!
    @IBOutlet weak var pad11: UIImageView!
    @IBOutlet weak var pad10: UIImageView!
    @IBOutlet weak var pad9: UIImageView!
    @IBOutlet weak var pad8: UIImageView!
    @IBOutlet weak var pad7: UIImageView!
    @IBOutlet weak var pad6: UIImageView!
    @IBOutlet weak var pad5: UIImageView!
    @IBOutlet weak var pad4: UIImageView!
    @IBOutlet weak var pad3: UIImageView!
    @IBOutlet weak var pad2: UIImageView!
    @IBOutlet weak var pad1: UIImageView!
    
    @IBOutlet weak var sideLabel: UILabel!
    @IBOutlet weak var sideCenter: NSLayoutConstraint!
    
    let padSequence = RequestPadSequence()
    
    var animationState = 0 // initial, 1 playing, 2 paused
    
    var pads = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pads = [pad1,pad2,pad3,pad4,pad5,pad6,pad7,pad8,pad9,pad10,pad11,pad12]
        
        sideLabel.text = "TAP TO START"
        // Do any additional setup after loading the view.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if animationState == 0{
            startAnimation()
            animationState = 1
        }else if animationState == 1{
            
        }
    }

    func startAnimation(){
        for i in padSequence.sequence{
            Timer.scheduledTimer(timeInterval: i.time, target: self, selector: #selector(animatePad), userInfo: i, repeats: false)
        }
    }
    
    @objc func animatePad(timer: Timer) {
        guard let context = timer.userInfo as? Pad else { return }
        print(context.color, " - ", context.pad," - ", context.time)
        
        var padNum : Int = context.pad
        
        if padNum >= 100{
            animatePageTransition(page: context.pad)
            return
        }
        
        if context.pad > 12{
           padNum = context.pad - 12
        }
        
//        print("pad ", padNum)
//        let animView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: pads[padNum-1].frame.size))
        
        let animView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: pads[padNum-1].frame.size))
        
        animView.layer.cornerRadius = animView.frame.height/10
        animView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        switch context.color {
        case "pink":
            animView.image = UIImage(named: "padTutorialPink")
        case "green":
            animView.image = UIImage(named: "padTutorialGreen")
        case "orange":
            animView.image = UIImage(named: "padTutorialOrange")
        case "blue":
            animView.image = UIImage(named: "padTutorialBlue")
        default:
            return
        }
        
        self.pads[padNum-1].clipsToBounds = false
        self.pads[padNum-1].addSubview(animView)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            animView.alpha = 0
            animView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: { finished in
            animView.removeFromSuperview()
        })
        
    }
    
    
    func animatePageTransition(page: Int){
        var pageName = "SIDE B"
        if page == 100{
            pageName = "SIDE A"
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.sideCenter.constant = -400
            self.sideLabel.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.sideCenter.constant = 400
            self.view.layoutIfNeeded()
            self.sideLabel.text = pageName
            UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.sideCenter.constant = 0
                self.sideLabel.alpha = 1
                self.view.layoutIfNeeded()
            })
        })
    }

}

