//
//  Comment.swift
//  PetWorld
//
//  Created by my mac on 7/22/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import Foundation
import Parse

class Comment: NSObject, PFObject, PFSubclassing{
    
    
    
    static func parseClassName() -> String {
        return "Comment"
    }

}

