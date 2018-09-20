import Foundation
import UIKit

import UIKit

class PageContainerViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var pages = [UIViewController]()
    
    var pageControl = UIPageControl()

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.index(of: viewController) else { return nil }
        
        let previousIndex = currentIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        
        guard pages.count > previousIndex else { return nil }
        
        let vc = pages[previousIndex] as? Demo2ViewController
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.index(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        
        if currentIndex == pages.count - 1 {
            if let finalViewController = pages[currentIndex] as? Demo2ViewController {
                finalViewController.button.isHidden = false
            }
        }

        guard nextIndex < pages.count else { return nil }
        
        guard pages.count > nextIndex else { return nil }

        let vc = pages[nextIndex] as? Demo2ViewController
        
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pages = createViewControllers()
        
        delegate = self
        dataSource = self
        
        configurePageControl()
        
        if let firstVc = pages.first {
            setViewControllers([firstVc], direction: .forward, animated: true, completion: nil)
        }

    }
    
    func createViewControllers() -> [Demo2ViewController] {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewControllers = [Demo2ViewController]()
        
        let vc = storyboard.instantiateViewController(withIdentifier: "demo2VC") as! Demo2ViewController
        vc.delegate = self
        vc.image = UIImage(named: "TableView")!
        vc.titleText = "TRACK YOUR PROGRESS"
        vc.point1 = "•    Quick and simple work-out tracking"
        vc.point2 = "•    Search bar to quickly find exercises"
        vc.point3 = "•    PB badge to highlight achievements"

        viewControllers.append(vc)
        
        let vc1 = storyboard.instantiateViewController(withIdentifier: "demo2VC") as! Demo2ViewController
        vc1.delegate = self
        vc1.image = UIImage(named: "Camerainsitu")!
        vc1.titleText = "BODY METRICS TRACKING"
        vc1.point1 = "•    User generated video to check form"
        vc1.point2 = "•    Video storage to track progress"
        vc1.point3 = ""
        viewControllers.append(vc1)
        
        let vc2 = storyboard.instantiateViewController(withIdentifier: "demo2VC") as! Demo2ViewController
        vc2.delegate = self
        vc2.image = UIImage(named: "ardemo")!
        vc2.titleText = "AR PERSONAL TRAINER"
        vc2.point1 = "•    AR PT to demonstrate strengenthing exercises"
        vc2.point2 = "•    AR trainer to follow correct form"
        vc2.point3 = ""
        viewControllers.append(vc2)
        
        print(viewControllers.count)
        
        
        return viewControllers
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let DemoViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pages.index(of: DemoViewController)!
    }
    
    func configurePageControl() {
                pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY-100, width: UIScreen.main.bounds.width, height: 100))
                pageControl.numberOfPages = pages.count
                pageControl.tintColor = UIColor.orange
                pageControl.pageIndicatorTintColor = UIColor.orange
                pageControl.currentPageIndicatorTintColor = UIColor.red
        
                self.view.addSubview(pageControl)
        
            }
    
}


extension PageContainerViewController: DemoDismiss {
    func shouldDismiss() {
        performSegue(withIdentifier: "Test", sender: self)
    }
    
    
    func didPreddButton() {
        
    }
    
}
