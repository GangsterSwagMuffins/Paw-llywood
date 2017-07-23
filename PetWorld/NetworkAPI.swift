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
                          //  print(newPet)
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
    
    class func postUserImage(photo: UIImage, caption: String?, success: PFBooleanResultBlock?) {
        let post = Post()
        
        post.media = getPhotoFile(photo: photo)
        post.author = Pet.currentPet() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post[""]
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: success)
        
    }
    
    
    class func getPosts(numPosts: Int, successHandler: @escaping ([Post])->(),  errorHandler: ((Error)->())?){
        // Query
        let query = PFQuery(className: "Post")
        query.includeKey("author")
        query.order(byDescending: "_created_at")
        //Populate the pet data field.
    
        
        query.limit = numPosts
        
        
        query.findObjectsInBackground { (postObjects: [PFObject]?, error: Error?) in
            if let error = error{
                print(error)
                if let errorHandler = errorHandler{
                     errorHandler(error)
                }
            }else{
                if let postObjects = postObjects { //Successfully grabbed posts objects
                    let posts: [Post] = postObjects as! [Post]
                    
                    for post in posts{
                        let pet = post["author"] as! Pet
                        print(pet)
                        post.author = pet
                        let petImage = pet["image"]
                        
                        
                        if let petImage = petImage{
                            NetworkAPI.loadPicture(imageFile: petImage as! PFFile, successBlock: { (image: UIImage) in
                                pet.image = image
                                successHandler(posts)
                            })
                        }
                        

                        if let owner = pet.owner{
                            loadOwner(userObject: owner, completionHandler: {
                                pet.owner = owner
                            }, errorHandler: nil)
                        }
                    }
                    
                    
                }
            }
            
        }
    }
    
    class func loadOwner(userObject: PFObject, completionHandler: @escaping ()->(), errorHandler: (()->())?){
        var user = userObject as! User
        user.fetchInBackground { (userObj: PFObject?, error: Error?) in
            if let error = error {
                print(error)
                if let errorHandler = errorHandler{
                    errorHandler()
                }
            }else{
                if let userObj = userObj{
                    user = userObj as! User
                    print("Pet Loaded")
                    
                        completionHandler()
                    
                    
                }
            }
        }
    
    }
    
    class func loadPet(petObject: PFObject, completionHandler:  (()->())?, errorHandler: (()->())?){
        var pet = petObject as! Pet
        pet.fetchInBackground { (petObj: PFObject?, error: Error?) in
            if let error = error {
                print(error)
                if let errorHandler = errorHandler{
                    errorHandler()
                }
            }else{
                if let petObj = petObj{
                    pet = petObj as! Pet
                    if let completionHandler = completionHandler{
                        completionHandler()
                    }
                    
                }
            }
        }
    }
    
    
    class func getLikedPosts(user: User){
         let query = PFQuery(className: "Post")
        
        query.whereKey("userLiked", equalTo: user)
    }
    
    class func resize(photo: UIImage, newSize: CGSize) -> UIImage {
        
        //Resize the image to match the siize that is passed in
        let resizedImage = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizedImage.contentMode = UIViewContentMode.scaleAspectFill
        resizedImage.image = photo
        
        //update the image on the view controller to the new size
        UIGraphicsBeginImageContext(resizedImage.frame.size)
        resizedImage.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    
    
    

}
