//
//  PostTableViewCell.swift
//  PetWorld
//
//  Created by Vinnie Chen on 5/16/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit


class PostTableViewCell: UITableViewCell{
    
    
    
    
    //Click to see all comments
    @IBOutlet weak var commentButton: UIButton!
    
    //The profile picture on top left of the screen
    @IBOutlet weak var profilePictureButton: UIButton!
    //The actual post image/video
    @IBOutlet weak var photoImage: UIImageView!
    
    //Username display top left of the screen
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var isLiked = false
    
    @IBOutlet weak var likeButton: UIButton!
    
    
    @IBAction func onLikeButtonTapped(_ sender: UIButton) {
        
        if (isLiked){
            isLiked = false
           likeButton.isSelected = false
        }else{
            isLiked = true
            likeButton.isSelected = true
        
        }
    }
    
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
            self.usernameButton.titleLabel?.textColor = TextManipulation.themeColor()
            
         self.profilePictureButton.layer.masksToBounds = true
            self.profilePictureButton.layer.cornerRadius = profilePictureButton.frame.width/2
            self.likeButton.setImage(UIImage(named: "catlikedpressedbutton"), for: .selected)
            self.likeButton.titleLabel?.textColor = TextManipulation.themeColor()
            self.captionLabel.textColor = TextManipulation.themeColor()
            
            
            if (post.username != nil){
                let captionText = "\(post.username!) - \(post.caption!)"
                let captionLen = captionText.characters.count
                //"First half" = username section of the string
                let firstHalfLen = post.username?.characters.count
                //"Second half" = caption section of the string including the dash
                let secondHalfLen = captionText.characters.count
                
                let range = NSMakeRange((post.username?.characters.count)!, (secondHalfLen - firstHalfLen!))
                
                let boldedString = TextManipulation.attributedString(from: captionText, nonBoldRange: range)
                
                captionLabel.attributedText = boldedString
            
            }
            
            
           
            
            
            //vtimestampLabel.text = post.timeStamp
        
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
