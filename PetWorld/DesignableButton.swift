//
//  DesignableButton.swift
//  PetWorld
//
//  Created by my mac on 7/1/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableButton: UIButton {
    
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
        
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
