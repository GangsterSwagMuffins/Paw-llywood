//
//  Comment.swift
//  PetWorld
//
//  Created by my mac on 7/22/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import Foundation
import Parse

class Comment: PFObject, PFSubclassing{
    
    
    @NSManaged var text: String?
    @NSManaged var owner: Pet?
    
    
    
    
    
    
    
    static func parseClassName() -> String {
        return "Comment"
    }
    
    

}

