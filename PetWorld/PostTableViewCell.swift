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
    @IBOutlet weak var likesLabel: UIButton!
    @IBOutlet weak var followButton: UIButton!
    
    
    
    var loadingState: Bool = false
    var isLoading: Bool  = false
    
    @IBOutlet weak var likeButton: UIButton!
    
    
    @IBAction func onLikeButtonTapped(_ sender: UIButton) {
        
        
        if let likes = self.post.likes as? Int{
            if (self.likeButton.isSelected){
                updateNumLikes(numLikes: NSNumber(value: likes - 1))
            }else{
                updateNumLikes(numLikes: NSNumber(value: likes + 1))

            }
        }
        
        
        updateLikeButton(liked: !self.likeButton.isSelected)
        
        
    }
    
    @IBAction func onFollowButtonTapped(_ sender: UIButton) {
        
        let currentPet = Pet.currentPet()
        let cell = sender.superview?.superview as! PostTableViewCell
        
        let postOwner  = cell.post.author!
        
        if self.followButton.isSelected{
            NetworkAPI.unfollow(follower: currentPet, followee: postOwner, completionHandler: {
                print("Succesfully unfollowed")
            }, errorHandler: { (error: Error) in
                print("Unsucessful unfollow")
            })
            
            self.followButton.isSelected = false
        }else{
            NetworkAPI.follow(follower: currentPet, followee: postOwner, completionHandler: {
                print("Successful follow")
            
            }, errorHandler: { (error: Error) in
                
                print("Unsucessful follow.")
            })
            
            self.followButton.isSelected = true                 
        }
        
    
        
    }
    
    
    var post : Post!{
        didSet{
            initLikeButton()
            initFollowButton()
            updateUI()
                
            }
  
        }
        
 
    
    func updateUI(){
        
       updateCaptionText()
        updateUsernameButton()
        updateProfilePicture()
        updateMedia()
        if let likes = self.post.likes{
            updateNumLikes(numLikes: likes)
        }
        //updateLikeButton()
        
    
    }

    func updateMedia(){
        if let image = post.image{
            self.photoImage.image = image
        }else{
            if let media = post.media{
                NetworkAPI.loadPicture(imageFile: media, successBlock: { (image: UIImage) in
                    self.post.image = image
                    self.photoImage.image = image
                })
            }
           
        }
    }
    
    
    func updateCaptionText(){
        var username: String = ""
        if let pet = post.author{
            if let name = pet.name{
                username = name
            }
        }
        
        
        if let caption = post.caption{
            let captionText = "\(username) - \(caption)"
            let captionLen = captionText.characters.count
            //"First half" = username section of the string
            let firstHalfLen = username.characters.count
            //"Second half" = caption section of the string including the dash
            let secondHalfLen = captionText.characters.count
            
            let range = NSMakeRange((username.characters.count
                ), (secondHalfLen - firstHalfLen))
            
            let boldedString = TextManipulation.attributedString(from: captionText, nonBoldRange: range)
            
            captionLabel.attributedText = boldedString
        
        }
        
    
    }
    
    func updateUsernameButton(){
        if let pet = post.author{
            
                if let name = pet.name{
                   // self.usernameButton.titleLabel?.text = name
                    
                    self.usernameButton.setTitle(name, for: UIControlState.normal)
                    self.usernameButton.setTitle(name, for: UIControlState.selected)
                    self.usernameButton.setTitle(name, for: UIControlState.highlighted)
                    self.usernameButton.setTitle(name, for: UIControlState.focused)
                    self.usernameButton.setTitle(name, for: UIControlState.reserved)
                    //self.usernameButton.titleLabel?.text = name
                }
            
        }
    }
    
    func updateLikeButton(liked: Bool){
       
        
        if (!isLoading){
            updateLike(liked: liked)
        }else{
            print("Still loading .....")
        }
        
        self.likeButton.isSelected = liked
        
        
    }
    
    func updateNumLikes(numLikes: NSNumber){
        self.likesLabel.setTitle("\(numLikes as! Int) likes", for: UIControlState.normal)
    }
    
    
    //TODO: Look below.
    func initLikeButton(){
        self.likeButton.setImage(UIImage(named: "white_heart"), for: UIControlState.normal)
        
        self.likeButton.setImage(UIImage(named: "dark_heart"), for: UIControlState.selected)
        
        self.likeButton.isSelected = self.post.liked
        

        
    }


   func updateProfilePicture(){
    self.profilePictureButton.layer.masksToBounds = true
    self.profilePictureButton.layer.cornerRadius = profilePictureButton.frame.width/2
    
    if let pet = post.author{
            if let picture = pet.image{
                //self.profilePictureButton.imageView?.image = picture
                self.profilePictureButton.setImage(picture, for: .normal)
                //self.profilePictureButton.setImage(picture, for: .selected)
                //self.profilePictureButton.setImage(picture, for: .focused)
               // self.profilePictureButton.setBackgroundImage(picture, for: .normal)
            }
        
       
    }
    
   }
    
    
    /*Makes a network call updating the liked status of a post.*/
    func updateLike(liked: Bool){
        
        self.loadingState = liked
        self.isLoading = true
        
        NetworkAPI.toggleLiked(withPost: self.post, byPet: Pet.currentPet(), withState: liked, completionHandler: { (success: Bool, error: Error?) in
            
            
            
            if let error = error{
                print("Could not toggle like! \(error)")
            }else{
                if success{
                    let newState:  Bool = self.likeButton.isSelected
                    if (newState != liked){
                        self.updateLike(liked: newState)
                        //More loading is required....
                    }else{//Finished loading
                        self.isLoading = false
                    }
                    
                    print("successfully toggled like")
                    
                }else{
                    print("successfully toggled like")
                }
            }
        })
        
    }
    
    
    func initFollowButton(){
        self.followButton.setTitle("Unfollow", for: UIControlState.selected)
        self.followButton.setTitle("Follow",for: UIControlState.normal)
        
        
        let currentPet = Pet.currentPet()
        if let followee = self.post.author{
            if currentPet.isFollowing(pet: self.post.author!){
                self.followButton.isSelected = true
            }else{
                self.followButton.isSelected = false
            }
        }
        
        
        
    }
    
    



}
