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
    var keyboardHeight: CGFloat = 0.0
    
    //The post that comment is being reffered by
    var post: Post?
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    
    
    
    @IBAction func onCommentStartEditing(_ sender: AnyObject) {
        print("comment start")
       // self.resignFirstResponder()
       // print(self.keyboardHeight)
        
       
        
    }
    
    
    @IBAction func onCommentEditingEnd(_ sender: Any) {
        print("comment end")
        print(self.keyboardHeight)
        self.commentTextField.resignFirstResponder()

        UIView.animate(withDuration: 0.2) {
            self.bottomConstraint.constant = 50
            self.commentTextField.layoutIfNeeded()
        }
    }
    
    
    
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
        self.commentTextField.text = ""
        self.commentTextField.endEditing(true)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector:  .keyboardWillShow, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification){
         let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        
        self.keyboardHeight = (keyboardSize?.height)!
        
        
        print("keyboardWillShow() called!\n_________\n\(keyboardSize)___________")
        UIView.animate(withDuration: 0.2) {
            self.bottomConstraint.constant = self.keyboardHeight + self.commentTextField.frame.size.height
        }
        
        
    
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

private extension Selector{
    static let keyboardWillShow = #selector(CommentViewController.keyboardWillShow(notification:))
    
}
