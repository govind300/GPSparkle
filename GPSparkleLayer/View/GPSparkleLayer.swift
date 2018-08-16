//
//  starLayer.swift
//  panStarAnimation
//
//  Created by mac on 08/08/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class GPSparkleLayer: CAShapeLayer {

    var numberOfSparkle = 6
    weak var sparkleImage = #imageLiteral(resourceName: "0")
    var sizeOfSparkle : CGFloat = 15
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    convenience init(frame aFrame : CGRect, image : UIImage = #imageLiteral(resourceName: "0"), count : Int = 10, size : Int = 10) {
        self.init()
        frame = aFrame
        sparkleImage = image
        numberOfSparkle = count
        sizeOfSparkle = CGFloat(size)
        setUp()
    }
    
    override init() {
        super.init()
    }
    
//    deinit {
//        print("Gone")
//    }
    
    func setUp(){
        backgroundColor = UIColor.clear.cgColor
        let aImg = sparkleImage
        
        for i in 1...numberOfSparkle{
            let aLayer = CAShapeLayer()
            aLayer.frame = CGRect(x: bounds.midX - (sizeOfSparkle/2), y: bounds.midY - (sizeOfSparkle/2), width: sizeOfSparkle, height: sizeOfSparkle)
            
            let aImgView = UIImageView(frame: aLayer.bounds)
            aImgView.image = aImg
            aLayer.addSublayer(aImgView.layer)
            
            setAnimation(OnIndex: i, forLayer: aLayer)
            addSublayer(aLayer)
        }
    }
    
    private func degreeToRadien(_ deg : Double)-> Double{
        return deg * Double.pi / 180
    }
    
    private func setAnimation(OnIndex aIndex: Int, forLayer : CAShapeLayer){
        let aNewAngle = degreeToRadien (Double(aIndex * (360 / numberOfSparkle)))
        
        let x = Double(bounds.width/2) * cos(aNewAngle) + Double(bounds.midX)
        let y = Double(bounds.width/2) * sin(aNewAngle) + Double(bounds.midY)
        
        let aNewX = x - Double(bounds.midX - (sizeOfSparkle/2))
        let aNewY = y - Double(bounds.midY - (sizeOfSparkle/2))
        
        let aAnimX = CABasicAnimation(keyPath: "transform.translation.x")
        aAnimX.toValue = aNewX
        
        let aAnimY = CABasicAnimation(keyPath: "transform.translation.y")
        aAnimY.toValue = aNewY
        
        let aFadeAnim = CABasicAnimation(keyPath: "opacity")
        aFadeAnim.toValue = 0
        
        let aGroupAnim = CAAnimationGroup()
        aGroupAnim.animations = [aAnimX,aAnimY,aFadeAnim]
        aGroupAnim.duration = 0.5
        aGroupAnim.delegate = self
        aGroupAnim.isRemovedOnCompletion = false
        aGroupAnim.fillMode = kCAFillModeForwards
        
        forLayer.add(aGroupAnim, forKey: "Anim")
    }
}

extension GPSparkleLayer : CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if let arrAllLayers = sublayers{
            for aLayer in arrAllLayers {
                aLayer.removeAllAnimations()
            }
        }
        
        
        removeAllAnimations()
        removeFromSuperlayer()
    }
}
