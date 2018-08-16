//
//  ViewController.swift
//  panStarAnimation
//
//  Created by mac on 08/08/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SettingModel: NSObject {
    var imageName : String = "0"
    var count = 6
    var size = 15
}

class AnimateVC: UIViewController {

    @IBOutlet var viewDrawing : UIView!
    
    var selectedImage = ""
    var setting = SettingModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let aSettingVC = storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        aSettingVC.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 70, width: UIScreen.main.bounds.size.width, height: 250)
        aSettingVC.settingModel = setting
        
        view.addSubview(aSettingVC.view)
        addChildViewController(aSettingVC)
        
        let aPanGesture = UIPanGestureRecognizer(target: self, action: #selector(getPan(_:)))
        viewDrawing.addGestureRecognizer(aPanGesture)
        
        let aTapGesture = UITapGestureRecognizer(target: self, action: #selector(getTap(_:)))
        viewDrawing.addGestureRecognizer(aTapGesture)
    }
    
    @objc func getTap(_ gesture : UITapGestureRecognizer){
        let aLocation = gesture.location(in: gesture.view)
        addStarAnimation(onLocation: aLocation)
    }
    
    @objc func getPan(_ gesture : UIPanGestureRecognizer){
        
        let aLocation = gesture.location(in: gesture.view)
        
        switch gesture.state {
        case .began:
//            print("Began")
//            print("\(aLocation)")
            addStarAnimation(onLocation: aLocation)
            
        case .changed:
//            print("changed")
//            print("\(aLocation)")
            addStarAnimation(onLocation: aLocation)
            
        case .ended:
            print("ended")
            
        case .cancelled:
            print("cancelled")
            
        case .failed:
            print("failed")
            
        default:
            print("Default")
        }
    }
    
    func addStarAnimation(onLocation aLoc: CGPoint){
        
        let aStarLayer = GPSparkleLayer(frame:  CGRect(x: aLoc.x - 50, y: aLoc.y - 50, width: 100, height: 100), image: UIImage(named: setting.imageName)!, count: setting.count, size: setting.size)
        
        viewDrawing.layer.addSublayer(aStarLayer)
    }
}

