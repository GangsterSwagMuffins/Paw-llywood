//
//  NetworkAPI.swift
//  PetWorld
//
//  Created by my mac on 7/18/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class NetworkAPI: NSObject {
    
    class func loadPicture(imageFile: PFFile, successBlock: ((UIImage)->Void)? ) ->UIImage?{
        var picture: UIImage?
        imageFile.getDataInBackground({ (imageData:Data?, error: Error?) in
            if let error = error{
                print("error: \(error)")
            }else{
                if let imageData = imageData{
                    picture = UIImage(data: imageData)
                    successBlock!(picture!)
                }
            }
            
        }) { (int: Int32) in
            print("totalProgress: \(int)%")
        }
        
        
        return picture
        
        
    }
    
    
    
    class func loadPets(finishedDownloading: @escaping ([Pet])->Void){
        
        //If there is a user then make this query for the pets.
        if let currentUser = User.current() {
            //List of pets that will populated from server
            var pets : [Pet] = []
            
            //Look for all pets with this user/owner
            let query = PFQuery(className: "Pet")
            query.whereKey("owner", equalTo: currentUser)
            
            query.findObjectsInBackground(block: { (petPFObjects: [PFObject]?, error: Error?) in
                if let error = error{//Quick error check
                    print("error: \(error.localizedDescription)")
                }else{
                    //Go through each PFObject
                    if let petPFObjects = petPFObjects{
                        for petPFObject in petPFObjects{
                            let newPet : Pet = petPFObject as! Pet
                            
                            //Some default fields until have screen to input this data
                            print(newPet)
                            newPet.breed = "Cairn Terrier"
                            newPet.species = "Dog"
                            newPet.age = 4
                            newPet.hobby = "Chewing Eddie's Socks"
                            newPet.toy = "My Binky"
                            newPet.gender = "Female"
                            newPet.followers = 10
                            newPet.following = 12
                            newPet.weight = 40
                            newPet.height = 20
                            newPet.miniBio = "#PureBreads#MAGA"
                            newPet.longBio = "I am Cairn Terrier and I love my walks!!!"
                            let petImage = UIImage(named: "Wolfie_Maga")
                            
                            newPet["image"] = getPhotoFile(photo:petImage)
                            newPet["backgroundImage"] = getPhotoFile(photo:petImage)
                            newPet.saveInBackground()
                            pets.append(newPet)
                            
                        }
                        
                    }
                    finishedDownloading(pets)
                }
            })
        }
    }

    
    class func getPhotoFile(photo: UIImage?) -> PFFile? {
        if let photo = photo {
            if let photo_data = UIImagePNGRepresentation(photo) {
                return PFFile(name: "wolfie.png", data: photo_data)
            }
        } else {
            return nil
        }
        return nil
    }
    
    
    
    

}
