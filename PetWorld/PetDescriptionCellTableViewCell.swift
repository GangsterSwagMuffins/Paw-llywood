//
//  PetDescriptionCellTableViewCell.swift
//  PetWorld
//
//  Created by my mac on 8/2/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class PetDescriptionCellTableViewCell: UITableViewCell {

    @IBOutlet weak var petNameLabel: UILabel!
    
    @IBOutlet weak var petImageView: UIImageView!
    
    @IBOutlet weak var ownerLabel: UILabel!
    
    
    
    var pet: Pet!{
        didSet{
            if let petName = pet.name{
                petNameLabel = petName
            }
            
            if let petImage = pet.image{
                petImageView.image = petImage
            }
            
            if let owner = pet.owner{
                if let ownerName = owner.username{
                    ownerLabel.text = ownerName
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
