//
//  Post.swift
//  PetWorld
//
//  Created by Vinnie Chen on 5/16/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    var username: String?
    var photo: UIImage?
    var caption: String?
    
    init(username: String, photo: UIImage, caption: String) {
        self.username = username
        self.photo = photo
        self.caption = caption
    }
    
    class func postUserImage(photo: UIImage, caption: String?, success: PFBooleanResultBlock?) {
        let post = PFObject(className: "Post")
        
        post["media"] = getPhotoFile(photo: photo)
        post["author"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: success)
        
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
