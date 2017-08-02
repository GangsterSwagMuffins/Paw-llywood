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
                           // print(newPet)
                            //Some default fields until have screen to input this data
                    /*      //  print(newPet)
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
                            newPet.saveInBackground()*/
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
        post.caption = caption
        post.likes = 0
        post.likedBy = [:]
        
        
        
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: success)
        
    }
    
    
    class func getPosts(numPosts: Int, forPet: Pet,  successHandler: @escaping ([Post])->(),  errorHandler: ((Error)->())?){
        // Query
        let query = PFQuery(className: "Post")
        query.whereKey("following", containedIn: Array(forPet.following!))
        query.includeKey(forPet.name!)
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
                    if (postObjects.count <= 0){
                        successHandler(posts)
                    }
                    
                    for post in posts{
                        let pet = post["author"] as! Pet
                        print("post__________\n\(post)\n_____________________")
                        //print(pet)
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
    
    
    class func getHomeFeed(numPosts: Int, successHandler: @escaping(([Post]) -> ()), errorHandler:  ((Error) -> ())?){
        getPosts(numPosts: numPosts, forPet: Pet.currentPet(), successHandler: successHandler, errorHandler: errorHandler)
     print("getHomeFeed()")
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
    
    
    class func getComments(withPost: Post, populateFields: Bool, successHandler: @escaping([Comment])->(),  errorHandler: @escaping(Error)->() ){
        
        let query = PFQuery(className: "Comment")
            query.includeKeys(["author"])
        query.whereKey("post", equalTo: withPost)
        
        query.order(byDescending: "_created_at")
        query.limit = 20
        
        query.findObjectsInBackground { (commentObjects: [PFObject]?, error: Error?) in
            if let error = error{
                print("An error has occurred: \(error.localizedDescription)")
                errorHandler(error)
            }else{

                if let commentObjects = commentObjects{
                    let comments: [Comment] = commentObjects as! [Comment]
                    
                    for comment in comments{
                        print(comment.allKeys)
                        //Every time a comment is loaded update screen
                        let post = comment.post
                        
                       
                        if let pet = comment.author{
                            if pet.image == nil{
                                let imageFile: PFFile? = pet["image"] as? PFFile
                                
                                if let imageFile = imageFile{
                                    loadPicture(imageFile: imageFile, successBlock: { (image: UIImage) in
                                        pet.image = image
                                        successHandler(comments)
                                    })
                                }
                            }
                        }
                       
                        
                            
                        
                        }
                        
                        successHandler(comments)
                        
                    }
                    
                }
            }
        }
    
    
    class func postComment(comment: Comment, successBlock: PFBooleanResultBlock?){
        comment.saveInBackground(block: successBlock)
        
    }
    
    
    class func update(post: Post, withResult: @escaping PFBooleanResultBlock){
       post.saveInBackground(block: withResult)
    }
    
    class func toggleLiked(withPost: Post, byPet: Pet, withState liked: Bool, completionHandler: @escaping PFBooleanResultBlock){
        if (liked){
            if (withPost.likedBy == nil){
                //Duck tape... Probably should initialize array when creating post.
                withPost.likedBy = [:]
            }
            
            if (byPet.likedPosts == nil){
                byPet.likedPosts = [:]
            }
            
            
            
            //Many to many relationship...
            if  let petId = byPet.objectId{
                withPost.likedBy?[petId] = byPet

            }
            if let postId = withPost.objectId{
                byPet.likedPosts?[postId] = withPost

            }
            //If the user likes add to the number of likes
            if let likes = withPost.likes as? Int{
                withPost.likes = NSNumber(value: likes + 1)
            }
            
            
        }else{
            if let postId = withPost.objectId{
                byPet.likedPosts?.removeValue(forKey: postId)
                print(byPet)
            }
            
            if let petId = byPet.objectId{
                withPost.likedBy?.removeValue(forKey: petId)
                print(withPost)

            }
            //If the user unliked remove from the number of likes
            if let likes = withPost.likes as? Int{
                withPost.likes = NSNumber(value: likes - 1)
            }
            
            
            
        }
        
        
        PFObject.saveAll(inBackground: [withPost, byPet], block: completionHandler)
        
        
        
        
    }
    
    
    
    class func follow(follower: Pet, followee: Pet, completionHandler: @escaping((Void) -> Void), errorHandler: @escaping((Error)-> Void)){
        if follower.following == nil{
            follower.following = [:]
        }
        
        if followee.followers == nil{
            followee.followers = [:]
        }
        
        follower.following?[followee.objectId!] = followee
        followee.followers?[follower.objectId!] = follower
        
        PFObject.saveAll(inBackground: [follower, followee]) { (success: Bool, error: Error?) in
            if success {
                completionHandler()
            }else{
                if let error = error{
                    errorHandler(error)
                }
               
            }
        }
   
    }
    
    
    class func unfollow(follower: Pet, followee: Pet, completionHandler: @escaping((Void) -> Void), errorHandler: @escaping((Error)-> Void)){
        if follower.following == nil{
            follower.following = [:]
        }
        
        if followee.followers == nil{
            followee.followers = [:]
        }
        
    
        
       
        follower.following?.removeValue(forKey: followee.objectId!)
        followee.followers?.removeValue(forKey: follower.objectId!)
        
        
        PFObject.saveAll(inBackground: [follower, followee]) { (success: Bool, error: Error?) in
            if success {
                completionHandler()
            }else{
                print(error)
            }
        }
        
    }
    
    class func createNewPet(withName: String, with profilePic: UIImage, completionHandler: @escaping PFBooleanResultBlock){
           let newPet = Pet()
        //TODO: Need to fix this really stupid.
           newPet["image"] = NetworkAPI.getPhotoFile(photo: profilePic)
           newPet.image = profilePic
        //Mini constructor code
        newPet.following = [:]
        newPet.followers = [:]
        newPet.likedPosts = [:]
        newPet.followingCount = 0
        newPet.followersCount = 0
        newPet.owner = User.current()
    
        newPet.saveInBackground(block: completionHandler)
    
    }
    
    
    }
    

    
    
    
    


