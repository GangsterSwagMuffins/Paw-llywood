//
//  Friend.swift
//  PetWorld
//
//  Created by Vinnie Chen on 5/27/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class Friend: NSObject {
    var name: String?
    var number: Int?
    
    init(name: String, number: Int ) {
        self.name = name
        self.number = number
    }
    
}
