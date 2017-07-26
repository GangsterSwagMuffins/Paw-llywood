//
//  Post.swift
//  PetWorld
//
//  Created by Vinnie Chen on 5/16/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class Post: PFObject, PFSubclassing {
    /**
     The name of the class as seen in the REST API.
     */
    public static func parseClassName() -> String {
         return "Post"
    }

    
  
   @NSManaged var petName: String?
   @NSManaged var author : Pet?
   @NSManaged var media: PFFile?
   @NSManaged var caption: String?
    @NSManaged var likedBy: [String: Pet]?
   @NSManaged var comments: [Comment]?
   @NSManaged var timeStamp : String?
    var image: UIImage?
    //Flag to check and see if a post is currently liked by the current Pet logged in
    var liked: Bool = false
    
   
    
    
}


