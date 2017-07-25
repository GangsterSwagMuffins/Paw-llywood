//
//  CommentTableViewCell.swift
//  PetWorld
//
//  Created by my mac on 7/23/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: DesignableImageView!
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
 
    var comment: Comment? {
        didSet{
            
            if let comment = comment{
                
                if let pet = comment.author{
                    if let profileImage = pet.image{
                        self.profileImageView.image = profileImage
                    }else{
                        let petImage: PFFile? = pet["image"] as? PFFile
                        if let petImage = petImage{
                            //Pet has no image
                            NetworkAPI.loadPicture(imageFile: pet["image"] as! PFFile, successBlock: { (image:UIImage) in
                                pet.image = image
                                self.profileImageView.image = image
                            })
                            
                        }
                       
                        print("pet has no image")
                    }
                    
                    if let username = pet.name{
                        self.usernameLabel.text = username
                        
                    }else{
                        //Pet had trouble loading username
                        print("pet has not username field")
                    }
                    
                }else{
                    //Pet was not loaded properly
                }
                
                if let commentText = comment.text{
                    self.commentLabel.text = commentText
                }else{
                    print("Trouble loading comment text.")
                }

            
                }
            }
        }

}
