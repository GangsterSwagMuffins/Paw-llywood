//
//  TextManipulation.swift
//  PetWorld
//
//  Created by my mac on 7/2/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class TextManipulation: NSObject {
    
    
    
    class func attributedString(from string: String, nonBoldRange: NSRange?) -> NSAttributedString {
        let fontSize = UIFont.systemFontSize
        let attrs = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: fontSize),
            NSForegroundColorAttributeName: UIColor.black
        ]
        let nonBoldAttribute = [
            NSFontAttributeName: UIFont.systemFont(ofSize: fontSize),
            ]
        let attrStr = NSMutableAttributedString(string: string, attributes: attrs)
        if let range = nonBoldRange {
            attrStr.setAttributes(nonBoldAttribute, range: range)
        }
        return attrStr
    }
    
    class func themeColor() -> UIColor{
        return  UIColor(red: 15/255.0, green: 15/255.0, blue: 163/255.0, alpha: 1.0); //Theme blue
    }
    
    class func secondaryColor() -> UIColor{
        return UIColor(red: 227/255, green: 208/255, blue: 66/255, alpha: 1.0);
    }

}
