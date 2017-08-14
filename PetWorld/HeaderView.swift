//
//  HeaderView.swift
//  PetWorld
//
//  Created by my mac on 7/30/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit


@IBDesignable
class HeaderView: UIView {

    @IBOutlet weak var titleText: UILabel!
    
   
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet weak var rightButton: UIButton!
    
    
    
    var onClickCallBack: ((Void)->Void)?
    
    var onRightClickCallBack: ((Void)->Void)?
    
    
    
    @IBInspectable
    var color: UIColor?{
        didSet{
            if let color = color{
                 self.backgroundView.backgroundColor = color
            }
            
            
           
        }
    }
    
    @IBInspectable
    var title: String?{
        didSet{
            titleText.text = title
        
        }
    
    }
    
    
    @IBInspectable
    var leftPicture: UIImage?{
        didSet{
            
            if let picture = leftPicture{
                leftButton.setImage(picture, for: UIControlState.normal)
            }
            
          //  leftButton.imageView.image = leftPicture
        }
    }
    
    @IBInspectable
    var rightPicture: UIImage?{
        didSet{
            if let picture = rightPicture{
                rightButton.setImage(picture, for: UIControlState.normal)
            }
            
        }
    }
    
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        
    }
    
    @IBAction func onTappedLeftButton(_ sender: Any) {
        onClickCallBack?()
        
    }
    
    @IBAction func onTappedRightButton(_ sender: Any) {
        
        onRightClickCallBack?()
        
    }
    
    func setupView(){
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        
        nib.instantiate(withOwner: self, options: nil)
    
        self.backgroundView.frame = bounds
        self.backgroundColor = ColorPalette.primary
        self.titleText.tintColor = UIColor.white
        addSubview(self.backgroundView)
    }
    
    
    
    

}
