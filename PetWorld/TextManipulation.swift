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
            NSForegroundColorAttributeName: TextManipulation.themeColor()
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
        return  ColorPalette.primary; //Theme blue
    }
    
    class func secondaryColor() -> UIColor{
        return UIColor.white
      //  return UIColor(red: 227/255, green: 208/255, blue: 66/255, alpha: 1.0);
    }

}

extension String{
    var isNumber: Bool{
        return Float(self) != nil
    }
}
