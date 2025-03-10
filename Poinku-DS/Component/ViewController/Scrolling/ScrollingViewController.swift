//
//  ScrollingViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 24/02/25.
//

import UIKit

class ScrollingViewController: UIViewController {
    private var uiStoryboard: UIStoryboard = UIStoryboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiStoryboard = UIStoryboard(name: "Main", bundle: nil)
    }
    
    
    @IBAction func GoToScrollingScale(_ sender: Any) {
        let vc = uiStoryboard.instantiateViewController(withIdentifier: "ScrollingScale")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func GoToScrollingFade(_ sender: Any) {
        let vc = uiStoryboard.instantiateViewController(withIdentifier: "ScrollingFade")
        navigationController?.pushViewController(vc, animated: true)
    }
}
