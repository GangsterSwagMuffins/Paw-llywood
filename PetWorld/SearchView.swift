//
//  SearchView.swift
//  PetWorld
//
//  Created by my mac on 8/2/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

@IBDesignable
class SearchView: UIView {
    //
    //  EmptyView.swift
    //  PetWorld
    //
    //  Created by my mac on 8/1/17.
    //  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
    //
    
   
    @IBOutlet var backgroundView: UIView!
        
        
    @IBOutlet weak var searchBar: UISearchBar!
        
        
    @IBOutlet weak var leftButton: UIButton!
    
    @IBInspectable
    var leftButtonImage: UIImage?{
        didSet{
            if let image = leftButtonImage{
              leftButton.setImage(image, for: UIControlState.normal)
            }
        }
    }
    
    
        var onLeftButtonTapped: ((UIButton)->(Void))?
        
    @IBAction func onLeftButtonTapped(_ sender: Any) {
        print("Left tapped form inside search view!!")
        onLeftButtonTapped?(sender as! UIButton)
        
    }
      
        
        override init(frame: CGRect){
            super.init(frame: frame)
            
            setupView()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupView()
            
        }
       
        
        func setupView(){
            UINib(nibName: "SearchView", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil)
            addSubview(backgroundView)
            backgroundView.frame = self.bounds
        }
        
    }


