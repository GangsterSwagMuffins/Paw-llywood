//
//  PublicPostViewController.swift
//  PetWorld
//
//  Created by my mac on 8/3/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import MBProgressHUD

class MyPostViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    
    var posts: [Post] = []
    var isLoading: Bool = false
    var isLoadingComments: Bool = false
    var pet: Pet?
    var cellTappedCallback: ((Post)->())?
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        if (!isLoading){
            print("loadPosts")
            
            loadPosts()
        }
        
        
        self.collectionView.reloadData()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (!isLoading){
            print("loadPosts")

            loadPosts()
           
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PublicPostCell", for: indexPath)as! PublicPostCollectionViewCell
        
        cell.post = posts[indexPath.item]
        cell.post.author = self.pet
        
        return cell
    
    }
    
  
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("cell index: \(indexPath.item)")
        print("press detected")
        
        cellTappedCallback?(self.posts[indexPath.item])
        
    }
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let screen = UIScreen.main.bounds
        let screenWidth = screen.size.width
        let screenHeight = screen.size.height
        
        return CGSize(width: collectionView.bounds.size.width/4 - 1, height: screenHeight / 7)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func loadPosts(){
        
        isLoading = true
        
        
        
        NetworkAPI.getPosts(numPosts: 20, forPet: pet!, successHandler: { (posts:[Post]) in
            self.posts = posts
            self.isLoading  = false
            self.collectionView.reloadData()
            for post in posts{
                self.checkIfPostIsLiked(post: post)
                self.loadComments(forPost: post)
            }
        }) { (error: Error) in
            self.isLoading = false
            print(error)
        }
        
        
    }
    
    func checkIfPostIsLiked(post: Post){
        let objectId = post.objectId
        // print(self.likedPosts)
        
        if let pet = Pet.currentPet(){
            if let objectId = objectId{
                if  let queryResult = pet.likedPosts?[objectId]{
                    post.liked = true
                }
                
            }
        }
        
    }
    
    
    
    func initLikedPosts(){
        let pet = Pet.currentPet()
        //  print(pet)
        
        if let pet = Pet.currentPet(){
            if (pet.likedPosts == nil){
                pet.likedPosts  = [:]//Duck tape
            }
            
            
        }
        // for post in pe
    }
    
    func loadComments(forPost: Post){
        self.isLoadingComments = true
        NetworkAPI.getComments(withPost: forPost, populateFields: true, successHandler: { (comments: [Comment]) in
            
            forPost.comments = comments
            self.isLoadingComments = false
            
        }) { (error: Error) in
            print("error occurred loading comments!")
        }
    }
    

}
