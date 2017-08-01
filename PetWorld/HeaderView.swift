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
        UINib(nibName: "HeaderView", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil)
        addSubview(backgroundView)
        backgroundView.frame = self.bounds
    }
    

}
