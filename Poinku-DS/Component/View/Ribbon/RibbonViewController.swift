//
//  RibbonViewController.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 03/02/25.
//

import UIKit

class RibbonViewController: UIViewController {
    
    @IBOutlet var testCard: UIView!
    @IBOutlet var testCard2: UIView!
    @IBOutlet var testCard3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testCard.backgroundColor = .grey20
        testCard2.backgroundColor = .grey20
        testCard3.backgroundColor = .grey20
        
        ribbonView1()
        ribbonView2()
        ribbonView3()
        
    }
    
    func ribbonView1() {
        let ribbonView = RibbonView()
        ribbonView.ribbonText = "x2"
        ribbonView.triangleColor = .blue50
        ribbonView.containerColor = .blue30
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
        ribbonView2.triangleColor = .orange50
        ribbonView2.containerStartColor = .yellow30
        ribbonView2.containerEndColor = .orange30
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
        ribbonView3.triangleColor = .red50
        ribbonView3.containerStartColor = .red20
        ribbonView3.containerEndColor = .red50
        ribbonView3.textColor = .white
        ribbonView3.gravity = .start

        ribbonView3.anchorToView(
            rootParent: view,
            targetView: testCard3,
            verticalAlignment: .center
        )
    }
}
