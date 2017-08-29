//
//  PublicPostCollectionViewCell.swift
//  PetWorld
//
//  Created by my mac on 8/3/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class PublicPostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var publicImageView: UIImageView!
    
    
    var post: Post!{
        didSet{
            publicImageView.image = post.image
        }
    
    }
    
    
    
    
}
