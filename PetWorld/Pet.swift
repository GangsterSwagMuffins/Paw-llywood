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

    var image: UIImage?
    var name: String?
    var breed: String?
    var age: Int?
    var gender: String?
    var followers: Int?
    var following: Int?
    
    
    
    class func addPet(user: User, profilePicture: UIImage, name: String, success: PFBooleanResultBlock?) {
        let pet = PFObject(className: "Pet")
        
        pet["owner"] = PFUser.current() // Pointer column type that points to PFUser
        
        pet["name"] = name
        pet["profile_picture"] =
        
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
