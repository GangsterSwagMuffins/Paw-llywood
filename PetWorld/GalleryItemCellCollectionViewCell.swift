//
//  GalleryItemCellCollectionViewCell.swift
//  PetWorld
//
//  Created by my mac on 5/23/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class GalleryItemCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var galleryPhoto: UIImageView!
    
    func setGalleryPhoto(image: UIImage){
        galleryPhoto.image = image
    
    }
    
    
}
