//
//  SettingVC.swift
//  panStarAnimation
//
//  Created by mac on 09/08/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class GPSlider: UISlider {
    @IBOutlet var lblMin : UILabel!
    @IBOutlet var lblMax : UILabel!
    @IBOutlet var lblCurrent : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class SettingVC: UIViewController {
    
    @IBOutlet var viewSetting : UIView!
    
    @IBOutlet var sliderCount : GPSlider!
    @IBOutlet var sliderSize : GPSlider!
    
    @IBOutlet var collectionItem : UICollectionView!
    
    var isMenuOpen = false
    var arrImages : [String] = []
    var settingModel : SettingModel!
    
    var minSize = 10
    var maxSize = 20
    var minCount = 3
    var maxCount = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for i in 0...15{
            arrImages.append("\(i)")
        }
        
        settingModel.imageName = arrImages.first!
        
        sliderSize.lblMin.text = "\(minSize)"
        sliderSize.lblMax.text = "\(maxSize)"
        sliderSize.lblCurrent.text = "\(settingModel.size)"
        sliderSize.value = Float((self.settingModel.size - minSize) / maxSize - minSize)
//        print("INITsliderSize -> \(sliderSize.value)")
        
        sliderCount.lblMin.text = "\(minCount)"
        sliderCount.lblMax.text = "\(maxCount)"
        sliderCount.lblCurrent.text = "\(settingModel.count)"
        sliderCount.value = Float((self.settingModel.count - minCount) / maxCount - minCount)
//        print("INITsliderCount -> \(sliderCount.value)")
        
        collectionItem.reloadData()
    }
    
    @IBAction func sliderAction(_ sender : GPSlider){
        
        if sender == sliderCount{
            self.settingModel.count = Int(((self.sliderCount.value) * Float(maxCount - minCount)) + Float(minCount))
            self.sliderCount.lblCurrent.text = "\(self.settingModel.count)"
            
            print("sliderCount -> \(self.settingModel.count)")
        }else{
            self.settingModel.size = Int(((self.sliderSize.value) * Float(maxSize - minSize)) + Float(minSize))
            self.sliderSize.lblCurrent.text = "\(self.settingModel.size)"
            
            print("sliderSize -> \(self.settingModel.size)")
        }
    }
    
    @IBAction func btnUpAction(_ sender : UIButton){
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.transform = self.isMenuOpen ? CGAffineTransform.identity : CGAffineTransform(translationX: 0, y: -(self.viewSetting.bounds.height) + 70)
            sender.transform = self.isMenuOpen ? CGAffineTransform.identity : CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }) { (_) in
            self.isMenuOpen = !self.isMenuOpen
        }
    }
    
}


extension SettingVC : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let aCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath)
        
        let aImgName = arrImages[indexPath.row]
        let aImg = aCell.viewWithTag(101) as! UIImageView
        aImg.image = UIImage(named: aImgName)!
        
        aCell.backgroundColor = aImgName == settingModel.imageName ? #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 0.5024614726) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        return aCell
    }
}

extension SettingVC : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        settingModel.imageName = arrImages[indexPath.row]
        collectionView.reloadData()
    }
}
