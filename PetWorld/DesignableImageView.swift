//
//  DesignableImageView.swift
//  PetWorld
//
//  Created by my mac on 6/29/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
@IBDesignable
class DesignableImageView: UIImageView {
    
    
    
    @IBInspectable var imageColor: UIColor?{
        didSet{
             tintColor = imageColor
        
        }
    
    }
    
    @IBInspectable var isCircle: Bool?{
        didSet{
            if ( isCircle != nil && isCircle!){
                self.layer.cornerRadius = self.frame.size.width / 2
                self.clipsToBounds = true
            }
        }
    
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
