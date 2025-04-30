//
//  OnBoardinggViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 25/04/25.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    @IBOutlet var onBoarding: OnBoarding!
    
    @IBOutlet var btnRegister: UIButton!
    @IBOutlet var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .top
        configureEdgeToEdgeUI()
        setupUI()
        setupSlides()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.setToolbarHidden(true, animated: animated)
        
        onBoarding.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onBoarding.viewWillDisappear()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func configureEdgeToEdgeUI() {
        onBoarding.collectionView.contentInsetAdjustmentBehavior = .never
        
        if let constraints = updateConstraintsForEdgeToEdge() {
            NSLayoutConstraint.activate(constraints)
        }
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func updateConstraintsForEdgeToEdge() -> [NSLayoutConstraint]? {
        guard onBoarding.collectionView.translatesAutoresizingMaskIntoConstraints == false else {
            return nil
        }
        
        return [
            onBoarding.collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            onBoarding.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onBoarding.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
    }
    
    private func setupSlides() {
        onBoarding.slides = [
            OnBoardingSlide(
                image: UIImage(named: "onboarding"),
                title: "Kumpulin Poin, Dapat Hadiah!",
                description: "Kumpulin Poin & Stamp dari setiap transaksi, tukarkan dengan hadiah yang cuma ada di sini!"),
            OnBoardingSlide(
                image: UIImage(named: "onboarding2"),
                title: "Anti Ribet, Nyaman Banget!",
                description: "Simpan struk belanja & cek riwayat transaksi kapan saja, semua dalam satu aplikasi."),
            OnBoardingSlide(
                image: UIImage(named: "onboarding3"),
                title: "Member Lebih Untung!",
                description: "Nikmati berbagai Promo Khusus Member, Diskon, Bonus, sampai Belanja Gratis, yang dijamin untung banget!")
        ]
    }
    
    private func setupUI() {
        let attrRegister = NSAttributedString(string: "Daftar Sekarang", attributes: [
            .font: Font.Button.Big.font,
            .foregroundColor: UIColor.white
        ])
        btnRegister.setAttributedTitle(attrRegister, for: .normal)
        btnRegister.contentEdgeInsets = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
        btnRegister.backgroundColor = UIColor.Blue.blue30
        btnRegister.tintColor = UIColor.Blue.blue30
        btnRegister.layer.cornerRadius = 8
        
        let attrLogin = NSAttributedString(string: "Masuk", attributes: [
            .font: Font.Button.Big.font,
            .foregroundColor: UIColor.Blue.blue30
        ])
        btnLogin.setAttributedTitle(attrLogin, for: .normal)
        btnLogin.layer.borderColor = UIColor.Blue.blue30.cgColor
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.cornerRadius = 8
        btnLogin.clipsToBounds = true
    }
    
}
