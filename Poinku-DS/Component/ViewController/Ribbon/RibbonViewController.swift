//
//  RibbonViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 21/02/25.
//

import UIKit

class RibbonViewController: UIViewController {
    
    @IBOutlet var testCard: UIView!
    @IBOutlet var testCard2: UIView!
    @IBOutlet var testCard3: UIView!
    @IBOutlet var btnTest: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testCard.backgroundColor = UIColor.Grey.grey20
        testCard2.backgroundColor = UIColor.Grey.grey20
        testCard3.backgroundColor = UIColor.Grey.grey20
        
        ribbonView1()
        ribbonView2()
        ribbonView3()
    }
    
    func ribbonView1() {
        let ribbonView = RibbonView()
        ribbonView.ribbonText = "x2"
        ribbonView.triangleColor = UIColor.Blue.blue50
        ribbonView.containerColor = UIColor.Blue.blue30
        ribbonView.textColor = .white
        ribbonView.gravity = .start

        ribbonView.anchorToView(
            rootParent: view,
            targetView: testCard
        )
    }
    
    func ribbonView2() {
        let ribbonView2 = RibbonView()
        ribbonView2.ribbonText = "Baru!"
        ribbonView2.triangleColor = UIColor.Orange.orange50
        ribbonView2.containerStartColor = UIColor.Yellow.yellow30
        ribbonView2.containerEndColor = UIColor.Orange.orange30
        ribbonView2.textColor = .white
        ribbonView2.gravity = .end

        ribbonView2.anchorToView(
            rootParent: view,
            targetView: testCard2,
            verticalAlignment: .center
        )
    }
    
    func ribbonView3() {
        let ribbonView3 = RibbonView()
        ribbonView3.ribbonText = "Hot Product!"
        ribbonView3.triangleColor = UIColor.Red.red50
        ribbonView3.containerStartColor = UIColor.Red.red20
        ribbonView3.containerEndColor = UIColor.Red.red50
        ribbonView3.textColor = .white
        ribbonView3.gravity = .start

        ribbonView3.anchorToView(
            rootParent: view,
            targetView: testCard3,
            verticalAlignment: .center
        )
    }
}
