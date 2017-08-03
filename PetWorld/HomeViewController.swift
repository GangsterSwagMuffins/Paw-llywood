//
//  HomeViewController.swift
//  PetWorld
//
//  Created by my mac on 4/10/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
// 

import UIKit
import Parse
import MBProgressHUD
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
    
    
    
    
    
    
    @IBAction func onProfileTapped(_ sender: UIView) {
        print("profileTapped!!!")

        
        
        let postViewCell = sender.superview?.superview as! PostTableViewCell
        self.performSegue(withIdentifier: "ProfileSegue", sender: postViewCell.post)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         initTableView()
        initLikedPosts()

        
        
        
        if (!isLoadingPosts){
            isLoadingPosts = true
            loadPosts()
        }
        
        
 
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        if (!isLoadingPosts){
            isLoadingPosts = true
            loadPosts()
        }
        if (!self.tableView.isHidden){
            self.tableView.reloadData()

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
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
        
       
       
        if let pet = Pet.currentPet(){
            //Start loading
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            NetworkAPI.getPosts(numPosts: 20, forPet: pet,   successHandler: { (posts: [Post]) in
                //Finished loading pets
                self.isLoadingPosts = false
                MBProgressHUD.hide(for: self.view, animated: true)
                //Update the GUI
                self.posts = posts
                print("_____\n\n\nfinished loading!!!\n\n\n________")
                for post in posts{
                self.checkIfPostIsLiked(post: post)
                }
                
                if posts.count <= 0 {
                self.tableView.isHidden = true
                }else{
                self.tableView.isHidden = false
                }
                
                self.tableView.reloadData()
                
                if (!self.isLoadingComments){
                self.isLoadingComments = true
                for post in posts{
                self.loadComments(forPost: post)
                }
                }
                
            }) { (error: Error) in
                MBProgressHUD.hide(for: self.view, animated: true)
                print(error)
            }
        
        }
        
       
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
        tableView.allowsSelection = false
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
    
    func findPost(withId: String)->Int?{
        var counter: Int = 0
        for post in self.posts{
            if (post.objectId == withId){
                return counter
            }
            counter = counter + 1
        }
        return nil
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ProfileSegue"){
            let profileViewController = segue.destination as! ProfileViewController
          if let post = sender as? Post{
            if let pet = post.author{
                 profileViewController.pet = pet
                print(pet)
                profileViewController.shouldShowEditButton = false
            }

            }
            
        }
    }
    

}


