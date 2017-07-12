//
//  Pet.swift
//  PetWorld
//
//  Created by my mac on 5/15/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class Pet: NSObject {

    //Profile pictre
    var image: UIImage?
    //Background profile picture
    var backgroundImage: UIImage?
    //Name of the pet.
    var name: String?
    var breed: String?
    var species: String?
    var age: Int?
    //Animals's favorite hobby
    var hobby: String?
    //Animal's favorite toy
    var toy: String?
    //Male or female none of this 55 gender stuff.
    var gender: String?
    //Don't be a folllower be a leader.
    var followers: Int?
    //Increase this.
    var following: Int?
    //Mini bio (32 characters max)
    var miniBio: String?
    //Long bio (256 characters max)
    var longBio: String?
    
    
    
    
    
    class func addPet(user: User, profilePicture: UIImage, name: String, success: PFBooleanResultBlock?) {
        let pet = PFObject(className: "Pet")
        
        pet["owner"] = PFUser.current() // Pointer column type that points to PFUser
        
        pet["name"] = name
        //pet["profile_picture"] =
        
        // Save object (following function will save the object in Parse asynchronously)
        pet.saveInBackground(block: success)
        
    }
    
    class func getPhotoFile(photo: UIImage?) -> PFFile? {
        if let photo = photo {
            if let photo_data = UIImagePNGRepresentation(photo) {
                return PFFile(name: "photo.png", data: photo_data)
            }
        } else {
            return nil
        }
        return nil
    }
}
