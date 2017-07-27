//
//  CommentViewController.swift
//  PetWorld
//
//  Created by my mac on 7/23/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var commentTextField: UITextField!
    
   var comments: [Comment] = []
    
    //The post that comment is being reffered by
    var post: Post?
    
    
    @IBAction func onBackButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true) { 
            print("Back button pressed.")
        }
    }
    

    @IBAction func onPostButtonTapped(_ sender: Any) {
        
        //Create new comment an init member fields
        let newComment = Comment()
        newComment.text = self.commentTextField.text
        newComment.author = Pet.currentPet()
        
        //Create link (relationship) Comment -> Post
        newComment.post = self.post
        
        //Create link (relationship) from Post -> Comment
        if let post = self.post {
            if post.comments == nil {
                post.comments = [newComment]
            }else{
                post.comments?.append(newComment)
            }
            //Autmatically update comments locally.
            comments.append(newComment)
            
            self.tableView.reloadData()


            //When the post is finished updating then udpdate the comment to avoid hanging/ deadlock.
            NetworkAPI.update(post: post, withResult: { (success: Bool, error: Error?) in
                
                self.updateComment(comment: newComment)
                
                if (success){
                    print("updated post with new comments")
                }else{
                    print(error)
                    
                }
            
            })
            
        }
        
        
       
       
        
      
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 600
        
        self.tableView.reloadData()
        self.tableView.allowsSelection = false
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return comments.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        cell.comment = comments[indexPath.row]
        
        return cell
        
    }
    
    
    
    
    func updateComment(comment: Comment){
        
        NetworkAPI.postComment(comment: comment) { (success: Bool, error: Error?) in
            if let error = error{
                print("Could not save comment...\n\n\(error)")
                //Do some kind of error handling...
            }else{
                if (success){
                    print("saved comment!")
                    
                    
                }
            }
        }
    }
    
    
    

   

}
