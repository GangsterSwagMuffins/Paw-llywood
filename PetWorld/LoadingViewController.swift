//
//  LoadingViewController.swift
//  PetWorld
//
//  Created by my mac on 7/25/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    weak var spinner: UIActivityIndicatorView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        if let spinner = spinner{
            spinner.bringSubview(toFront: spinner)
            spinner.startAnimating()
            
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("View did appear")
        if let spinner = self.spinner{
            print("Is spinner spinning: \(spinner.isAnimating)")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if let spinner = self.spinner{
            spinner.stopAnimating()
            
        }
        
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
