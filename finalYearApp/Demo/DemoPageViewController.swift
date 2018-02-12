import Foundation
import UIKit

class DemoPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    lazy var subViewControllers:[UIViewController] = {
        
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "demoVC") as! DemoViewController,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "demo1VC") as! Demo1ViewController,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "demo2VC") as! Demo2ViewController
            
        ]
    }()
    
    var pageControl = UIPageControl()

    
    override func viewDidLoad() {
        super .viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        configurePageControl()
        
        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)
    }
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY-100, width: UIScreen.main.bounds.width, height: 100))
        pageControl.numberOfPages = subViewControllers.count
        pageControl.tintColor = UIColor.orange
        pageControl.pageIndicatorTintColor = UIColor.orange
        pageControl.currentPageIndicatorTintColor = UIColor.red
        
        self.view.addSubview(pageControl)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let DemoViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = subViewControllers.index(of: DemoViewController)!
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.index(of: viewController) ?? 0
        if(currentIndex <= 0) {
            return nil
        }
        return subViewControllers[currentIndex-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentIndex: Int = subViewControllers.index(of: viewController) ?? 0
        if(currentIndex >= subViewControllers.count-1) {
            return nil
        }
        return subViewControllers[currentIndex+1]
    }
    
}
