//
//  VerifyPhotoViewController.swift
//  PetWorld
//
//  Created by my mac on 5/27/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class VerifyPhotoViewController: UIViewController {

    @IBOutlet weak var chosenPicture: UIImageView!
    var picture: UIImage?
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        chosenPicture.image = picture
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
