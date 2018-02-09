//
//  MyPageViewController.swift
//  moneyBook
//
//  Created by p14822 on 2018/2/8.
//  Copyright © 2018年 p14822. All rights reserved.
//

import UIKit

class MyPageViewController: UIPageViewController, UIPageViewControllerDataSource{

    var ViewList = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        let cameraViewController = storyboard?.instantiateViewController(withIdentifier: "CameraViewController")
        let photoController = storyboard?.instantiateViewController(withIdentifier: "PhotoViewController")
        
        ViewList.append(cameraViewController!)
        ViewList.append(photoController!)
        
        setViewControllers([ViewList[0]], direction: .forward, animated: true, completion: nil)
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = .black
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for v in view.subviews{
            if v is UIScrollView{
                v.frame = view.bounds
                break
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let pageIndex = ViewList.index(of: viewController) , pageIndex > 0{
            return ViewList[pageIndex - 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let pageIndex = ViewList.index(of: viewController) , pageIndex < ViewList.count - 1{
            return ViewList[pageIndex + 1]
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return ViewList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
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
