//
//  PageViewController.swift
//  mamawhatscooking
//
//  Created by Mario Lin on 12/6/17.
//  Copyright © 2017 Mario Lin. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        // Do any additional setup after loading the view.
        
        let p1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "page1")
        let p2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "page1")
        let p3: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "page1")
        
        pages.append(contentsOf: [p1, p2, p3])
        setViewControllers([p1], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
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

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let cur = pages.index(of: viewController)!
        
         if cur == 0 { return nil }
        
        let prev = abs((cur - 1) % pages.count)
        return pages[prev]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController)-> UIViewController? {
        
        let cur = pages.index(of: viewController)!
        
         if cur == (pages.count - 1) { return nil }
        
        let nxt = abs((cur + 1) % pages.count)
        return pages[nxt]
    }
    
    func presentationIndex(for pageViewController: UIPageViewController)-> Int {
        return pages.count
    }
    
}

extension PageViewController: UIPageViewControllerDelegate {
    
}
