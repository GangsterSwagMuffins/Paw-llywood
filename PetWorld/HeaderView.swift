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
    
    
    
    
    var onClickCallBack: ((Void)->Void)?
    
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
            leftButton.setImage(leftPicture, for: UIControlState.normal)
          //  leftButton.imageView.image = leftPicture
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
    
    
    func setupView(){
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        
        nib.instantiate(withOwner: self, options: nil)
    
        self.backgroundView.frame = bounds
        
        addSubview(self.backgroundView)
    }
    
    
    
    

}
