//
//  Regsiter1ViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 11/06/25.
//

import UIKit

class Register1ViewController: UIViewController {
    
    @IBOutlet var vStep: StepPageNav!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        vStep.title = ["Isi Data Diri", "Verifikasi", "Buat PIN"]
        vStep.currentStep = 3
    }
    
}
