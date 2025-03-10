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
        
        testCard.backgroundColor = .grey20
        testCard2.backgroundColor = .grey20
        testCard3.backgroundColor = .grey20
        
        ribbonView1()
        ribbonView2()
        ribbonView3()
        
        showCoachmark()
    }
    
    func showCoachmark2() {
        let coachmark = Coachmark(frame: view.bounds)
        
        coachmark.configure(
            title: "Add New Item",
            description: "Tap this button to add a new item to your list",
            targetView: btnTest
        )
        
        coachmark.show()
    }
    
    func showCoachmark() {
        let coachmark = Coachmark(frame: .zero)

        coachmark.configureSteps(steps: [
            Coachmark.StepConfiguration(
                title: "Step 1",
                description: "This is the first step step step step 2 steps yesss no masih kurang ya ges ya terus kita cobain kalo misal ininya lebih dari 3 lines kaya gimana. ternyata masih kurang gess kurang panjang",
                targetView: btnTest
            ),
            Coachmark.StepConfiguration(
                title: "Step 2",
                description: "This is the second step",
                targetView: testCard,
                spotlightRadius: 8
            ),
            Coachmark.StepConfiguration(
                title: "Step 3",
                description: "This is the final step",
                targetView: testCard3
            )
        ])

        coachmark.show()
    }
    
    @objc func dismissCoachmark() {
        view.subviews.forEach { subview in
            if let coachmark = subview as? Coachmark {
                coachmark.dismiss()
            }
        }
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
