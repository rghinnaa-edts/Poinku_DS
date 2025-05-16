//
//  ProfileViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 30/04/25.
//

import UIKit

class Profile2ViewController: UIViewController {
    
    @IBOutlet var vMember: UIView!
    @IBOutlet var vMGM: UIView!
    @IBOutlet var vGoogleWallet: UIView!
    
    @IBOutlet var lblMemberName: UILabel!
    @IBOutlet var lblSeeDetail: UILabel!
    @IBOutlet var ivMember: UIImageView!
    @IBOutlet var lblMemberType: UILabel!
    @IBOutlet var ivPhone: UIImageView!
    @IBOutlet var lblPhone: UILabel!
    @IBOutlet var lblAccumulationTitle: UILabel!
    @IBOutlet var lblAccumulation: UILabel!
    @IBOutlet var progressAccumulation: UIProgressView!
    @IBOutlet var lblTransactionTitle: UILabel!
    @IBOutlet var lblTransaction: UILabel!
    @IBOutlet var progressTransaction: UIProgressView!
    
    @IBOutlet var ivMGM: UIImageView!
    @IBOutlet var ivArrowRight: UIImageView!
    @IBOutlet var lblMGM: UILabel!
    @IBOutlet var lblMGMDesc: UILabel!
    @IBOutlet var ivGoogleWallet: UIImageView!
    @IBOutlet var lblGoogleWallet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        showCoachmark()
    }
    
    func setupUI() {
        vMember.backgroundColor = UIColor.Yellow.yellow30
        vMember.layer.cornerRadius = 8
        
        vMGM.backgroundColor = UIColor.white
        vMGM.layer.borderWidth = 1
        vMGM.layer.borderColor = UIColor.blue30.cgColor
        vMGM.layer.cornerRadius = 8
        
        vGoogleWallet.backgroundColor = UIColor.black
        vGoogleWallet.layer.cornerRadius = 20
        
        lblMemberName.font = Font.B2.Medium.font
        lblMemberName.textColor = UIColor.white
        lblMemberName.text = "Edward Newgate"
        
        lblSeeDetail.font = Font.B4.Small.font
        lblSeeDetail.textColor = UIColor.white
        lblSeeDetail.text = "Lihat Detail"
        
        ivMember.image = UIImage(named: "placeholder")?.withRenderingMode(.alwaysTemplate)
        ivMember.tintColor = UIColor.white
        
        lblMemberType.font = Font.B4.Small.font
        lblMemberType.textColor = UIColor.white
        lblMemberType.text = "Gold Member"
        
        ivPhone.image = UIImage(named: "placeholder")?.withRenderingMode(.alwaysTemplate)
        ivPhone.tintColor = UIColor.white
        
        lblPhone.font = Font.B4.Small.font
        lblPhone.textColor = UIColor.white
        lblPhone.text = "0812 3456 7890"
        
        lblAccumulationTitle.font = Font.B4.Small.font
        lblAccumulationTitle.textColor = UIColor.white
        lblAccumulationTitle.text = "Akumulasi Transaksi"
        
        lblAccumulation.font = Font.B4.Small.font
        lblAccumulation.textColor = UIColor.white
        lblAccumulation.text = "850.000/2.700.000"
        
        lblTransactionTitle.font = Font.B4.Small.font
        lblTransactionTitle.textColor = UIColor.white
        lblTransactionTitle.text = "Jumlah Transaksi"
        
        lblTransaction.font = Font.B4.Small.font
        lblTransaction.textColor = UIColor.white
        lblTransaction.text = "9/15"
        
        ivMGM.image = UIImage(named: "mgm")
        ivArrowRight.image = UIImage(named: "placeholder")?.withRenderingMode(.alwaysTemplate)
        ivArrowRight.tintColor = UIColor.blue30
        
        lblMGM.font = Font.H2.font
        lblMGM.textColor = UIColor.blue30
        lblMGM.text = "Ajak Teman, Dapat Untung Bareng!"
        
        lblMGMDesc.font = Font.B4.Small.font
        lblMGMDesc.textColor = UIColor.grey60
        lblMGMDesc.text = "Bagikan kode referral kamu untuk mendapatkan hadiah."
        
        ivGoogleWallet.image = UIImage(named: "googlewallet")
        lblGoogleWallet.text = "Tambahkan ke Google Wallet"
        lblGoogleWallet.textColor = UIColor.white
    }
    
    func showCoachmark() {
        let coachmark = Coachmark(frame: .zero)

        coachmark.configureSteps(steps: [
            Coachmark.StepConfiguration(
                title: "Program Referral",
                description: "Bagikan kode referral untuk mendapatkan hadiah setiap kali ada teman yang bergabung.",
                targetView: vMGM
            )
        ])

        coachmark.show()
    }
}
