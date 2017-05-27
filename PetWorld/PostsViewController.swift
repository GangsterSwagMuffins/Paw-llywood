//
//  PostsViewController.swift
//  PetWorld
//
//  Created by Vivian Pham on 5/6/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class PostsViewController: UIPageViewController, UIPageViewControllerDataSource {

    
    
    //List of view controllers to be returned
    private(set) lazy var mediaViewControllers: [UIViewController] = {
        return [self.pickMediaViewController(mediaType: "Gallery"),
                self.pickMediaViewController(mediaType: "Photo"),
                self.pickMediaViewController(mediaType: "Video")]
    }()
    
    private func pickMediaViewController(mediaType: String) -> UIViewController{
        //Return the View Controller based on it's storyboard identifier
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(mediaType)ViewController")
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstViewController = mediaViewControllers.first{
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil
                               )
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        guard let viewControllerIndex = mediaViewControllers.index(of: viewController)else{
            return nil
        }
        
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else{
            return nil
            
        }
        return mediaViewControllers[previousIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = mediaViewControllers.index(of: viewController) else{
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        let mediaControllersCount = mediaViewControllers.count
        
        guard mediaControllersCount != nextIndex else {
            return nil
        }
        
        
        guard mediaControllersCount > nextIndex else {
            
            return nil
        }
        
        
        
        return mediaViewControllers[nextIndex]
    }
    
    
    /*To show the dots....*/
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return mediaViewControllers.count
    }
    
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = mediaViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
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
