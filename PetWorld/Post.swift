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
    var author : User?
    var media: PFFile?
    var caption: String?
    var likesCount : Int?
    var commentsCount : Int?
    var timeStamp : String?
    
    weak var delegate: PhotoLoadedDelegate?
    
    
    
    
    
    
    
    
    func constructor(postMap: PFObject, tableView: UITableView) {
        //Extract username
        
        let user : PFObject = postMap["author"] as! PFObject
        
        print("object ID: \(user.objectId!)")
        
        if let id = user.objectId{
            var query = PFQuery(className: "_User")
            query.getObjectInBackground(withId: id, block: { (user: PFObject?, error: Error?) in
                if (error == nil){
                    print("data from the network: \(user!)")
                    let user_obj = user as! User
                    print(user_obj)
                    print("the username from network: \(user_obj.username!)")
                    
                        self.username = user_obj.username!
                    tableView.reloadData()
                    
                
                }
            })
        
        
        }
        
        print("username extracted: \(username)")
        print(postMap)
        
        //Extract the photo/video
      
        var mediaTemp: UIImage?
        
        //Extrct media file data
         media = postMap["media"] as! PFFile
        
        
     
        
       
        
        //Extract the time created
        timeStamp = postMap["_created_at"] as? String
        
        //Extract the caption text
        caption = postMap["caption"] as? String
    
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


protocol PhotoLoadedDelegate: class{
    func photoLoaded(picture:UIImage, post: Post, tableview: UITableView)

}

