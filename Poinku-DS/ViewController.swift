//
//  ViewController.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 09/01/25.
//

import UIKit

class ViewController: UIViewController {
    
//    var mainView: HomeSwitcher { return self.view as! HomeSwitcher}
    private var uiStoryboard: UIStoryboard = UIStoryboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        if let switcher = Bundle.main.loadNibNamed("HomeSwitcher", owner: self, options: nil)?.first as? HomeSwitcher {
//            self.view.addSubview(switcher)
//        }
    }
    
//    override func loadView() {
//        self.view = HomeSwitcher(frame: UIScreen.main.bounds)
//    }
    
    @IBAction func GoToDoubleArc(_ sender: Any) {
        let vc = uiStoryboard.instantiateViewController(withIdentifier: "DoubleArc")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GoToScrollView(_ sender: Any) {
        let vc = uiStoryboard.instantiateViewController(withIdentifier: "StampCard")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GoToRibbon(_ sender: Any) {
        let vc = uiStoryboard.instantiateViewController(withIdentifier: "Ribbon")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GoToScrolling(_ sender: Any) {
        let vc = uiStoryboard.instantiateViewController(withIdentifier: "Scrolling")
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

