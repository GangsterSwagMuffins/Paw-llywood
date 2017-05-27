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
    
    init(name: String, image: UIImage, breed: String, age: Int, gender: String ) {
        self.name = name
        self.image = image
        self.breed = breed
        self.age = age
        self.gender = gender
    }
    
    class func addPet(photo: UIImage, name: String, image: UIImage, breed: String, age: Int, gender: String, success: PFBooleanResultBlock?) {
        let pet = PFObject(className: "Pet")
        pet["photo"] = getPhotoFile(photo: photo)
        pet["owner"] = PFUser.current() // Pointer column type that points to PFUser
        
        pet["name"] = name
        pet["breed"] = breed
        pet["age"] = age
        pet["followersCount"] = 0
        pet["followingCount"] = 0
        
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
