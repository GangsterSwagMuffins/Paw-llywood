//
//  HomeViewController.swift
//  PetWorld
//
//  Created by my mac on 4/10/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
// 

import UIKit
import Parse
import AVFoundation

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
  
    var posts: [Post] = []
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    //True when making network requests
    var isLoadingComments: Bool  = false
    var isLoadingPosts: Bool = false
    var commentViewController: CommentViewController?
    var likedPosts: [String: Post] = [:]
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
         initTableView()
        if (Pet.currentPet().name! == "STUB"){
         initLikedPosts()
        }
        
        if (!isLoadingPosts){
            isLoadingPosts = true
            loadPosts()
        }
        
        
 
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if (!isLoadingPosts){
            isLoadingPosts = true
            loadPosts()
        }
       
        self.tableView.reloadData()
    }
    
    // Table functions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        //So we don't have to look at old pictures since we are reusing cells.
        if (cell.imageView?.image != nil){
            cell.imageView?.image = nil
        }
   
        cell.post = posts[indexPath.row]

        return cell
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TODO: See comments nested in the function.
    @IBAction func onCommentButtonTapped(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let commentViewController = storyboard.instantiateViewController(withIdentifier: "CommentViewController") as! CommentViewController
        
        let cell = sender.superview?.superview as! PostTableViewCell
        commentViewController.post = cell.post
        print(cell.post)
        commentViewController.comments = cell.post.comments!
        print(cell.post.comments)
        
        
        self.present(commentViewController, animated: true) { 
            print("Loaded comment View Controller")
        }
    }
    
    
    
    
    
    
    func loadPosts(){
        
        NetworkAPI.getPosts(numPosts: 20, successHandler: { (posts: [Post]) in
            //Finished loading pets
            self.isLoadingPosts = false
            //Update the GUI
            self.posts = posts
            
            for post in posts{
                self.checkIfPostIsLiked(post: post)
            }
            
            self.tableView.reloadData()
            
            if (!self.isLoadingComments){
                self.isLoadingComments = true
                for post in posts{
                    self.loadComments(forPost: post)
                }
            }
            
            
        }, errorHandler: nil)
        
    }
    
    func loadComments(forPost: Post){
        NetworkAPI.getComments(withPost: forPost, populateFields: true, successHandler: { (comments: [Comment]) in
            
            forPost.comments = comments
            self.isLoadingComments = false
            
        }) { (error: Error) in
            print("error occurred loading comments!")
        }
    }
    
    func initTableView(){
        //Set up autolayout
        tableView.rowHeight = UITableViewAutomaticDimension
        //For the scrolling bar size
        tableView.estimatedRowHeight = 600
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func checkIfPostIsLiked(post: Post){
        let objectId = post.objectId
        print(Pet.currentPet().likedPosts)
        print(self.likedPosts)
        if let objectId = objectId{
            let queryResult = self.likedPosts[objectId]
            if let likedPost = queryResult{
                likedPost.liked = true
            }
        }
        
    }
    
    func initLikedPosts(){
        let pet = Pet.currentPet()
        print(pet)
        if (pet.likedPosts == nil){
            pet.likedPosts  = []//Duck tape
        }
        
        //Put all liked posts in map.
        for post in pet.likedPosts!{
            if let objectId = post.objectId{
                self.likedPosts[objectId] = post
            }
            
        }
        
       // for post in pe
    }



}
