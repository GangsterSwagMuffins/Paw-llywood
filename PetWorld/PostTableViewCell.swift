//
//  PostTableViewCell.swift
//  PetWorld
//
//  Created by Vinnie Chen on 5/16/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit


class PostTableViewCell: UITableViewCell{
    
    
    
    
    
    @IBOutlet weak var commentButton: UIButton!
    
    @IBOutlet weak var profilePictureButton: UIButton!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    var post : Post!{
        didSet{
            let mediaFile = post.media
            
            mediaFile?.getDataInBackground { (data: Data?, error: Error?) in
                if let data = data {
                    print("Successdfully received data!")
                    self.photoImage.image = UIImage(data: data)
                    
                    
                }
                else {
                    print(error?.localizedDescription ?? "")
                    
                }
                
            }
            
            print("Here is the author fo the post \(post.username)")
            usernameButton.setTitle(post.username, for: UIControlState.normal)
            
            
            //vtimestampLabel.text = post.timeStamp
         //   captionLabel.text = post.caption
        
        }
    
    
    }
    
    
    
    @IBAction func onUsername(_ sender: Any) {
    
        
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
