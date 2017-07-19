//
//  DesignableTextField.swift
//  PetWorld
//
//  Created by my mac on 6/28/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {
    
    
    
    var showRightView = false
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        
        
        }
    
    
    }
    
    @IBInspectable var rightLabel: String?{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var rightImage: UIImage?{
        didSet{
            updateView()
        
        }
    
    }
    
    @IBInspectable var leftImage: UIImage?{
        didSet{
            updateView()
        
        }
    
    }
    
    @IBInspectable var rightPadding: CGFloat = 0{
        didSet{
            updateView()
        
        }
    
    }
    
    @IBInspectable var leftPadding: CGFloat = 0{
        didSet{
            updateView()
        
        }
    
    
    }
    
    @IBInspectable var hasBottomLine: Bool = false{
        didSet{
            if (hasBottomLine){
                setBottomBorder()
            }
        }
    
    }
    
    
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func updateView(){
        
        
        if let rightLabel = rightLabel{
            
            rightViewMode = .always
            //There is a right image set
            let label = UILabel(frame: CGRect(x: self.bounds.width - 20, y: 0, width: 20, height: 20) )
            var width = rightPadding + 20
            
            if (borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line){
                width = width + 5
                
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20 ))
            view.addSubview(label)
            label.text = rightLabel
            label.tintColor = UIColor.red
            
            rightView = view
            
            
            
        }else{
            //There is no right image set nil bruh
            rightViewMode = .never
            
        }
        
        
        
        
        
        if let leftImage = leftImage{
            //There is an image
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            
            
            var width = leftPadding + 20
            
            //For these two border styles we may need more space
            if (borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line){
                width = width + 5
            
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20 ) )
            view.addSubview(imageView)
            
            
            imageView.image = leftImage
            imageView.tintColor = tintColor
            
            leftView = view
        }else{
             //Image is nil
            leftViewMode = .never
        }
        
       
        
        if let rightImage = rightImage{
            
            rightViewMode = .always
        //There is a right image set
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20) )
            var width = rightPadding + 20
            if (borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line){
                width = width + 5
                
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20 ))
            view.addSubview(imageView)
            imageView.image = rightImage
            imageView.tintColor = UIColor.red
            
            rightView = view
            
            
        
        }else{
        //There is no right image set nil bruh
            rightViewMode = .never
        
        }
        
        if (showRightView == true){
            rightViewMode = .always
        }else{
            rightViewMode = .never 
        }
        
       
        
        
        
        
        
        
        let placeholder_string = (placeholder != nil) ? placeholder! : ""
        
        attributedPlaceholder = NSAttributedString(string: placeholder_string , attributes: [NSForegroundColorAttributeName : tintColor])
    
    
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
