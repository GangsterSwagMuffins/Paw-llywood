//
//  DesignableTableView.swift
//  PetWorld
//
//  Created by my mac on 7/3/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTableView: UITableView {
    
    
    @IBInspectable var backgroundImage: UIImage?{
        didSet{
            let imageView = UIImageView()
            imageView.image = backgroundImage
            
            self.backgroundView = imageView
        
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
