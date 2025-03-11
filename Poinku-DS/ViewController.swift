//
//  ViewController.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 09/01/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func GoToDoubleArc(_ sender: Any) {
        let vc = UIStoryboard(name: "DoubleArcViewController", bundle: nil).instantiateViewController(withIdentifier: "DoubleArc")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GoToCard(_ sender: Any) {
        let vc = UIStoryboard(name: "CardViewController", bundle: nil).instantiateViewController(withIdentifier: "Card")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GoToRibbon(_ sender: Any) {
        let vc = UIStoryboard(name: "RibbonViewController", bundle: nil).instantiateViewController(withIdentifier: "Ribbon")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GoToScrolling(_ sender: Any) {
        let vc = UIStoryboard(name: "ScrollingViewController", bundle: nil).instantiateViewController(withIdentifier: "Scrolling")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GoToSkeleton(_ sender: Any) {
        let vc = UIStoryboard(name: "SkeletonViewController", bundle: nil).instantiateViewController(withIdentifier: "Skeleton")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GoToCoachmark(_ sender: Any) {
        let vc = UIStoryboard(name: "CoachmarkViewController", bundle: nil).instantiateViewController(withIdentifier: "Coachmark")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GoToStampPage(_ sender: Any) {
        let vc = UIStoryboard(name: "StampPageViewController", bundle: nil).instantiateViewController(withIdentifier: "StampPage")
        navigationController?.pushViewController(vc, animated: true)
    }
}

