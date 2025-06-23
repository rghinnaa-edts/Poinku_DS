//
//  VerificationViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 24/04/25.
//

import UIKit

class VerificationViewController: UIViewController {
    
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var vToolbar: UIView!
    @IBOutlet var lblToolbar: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var btnVerifWhatsapp: UIButton!
    @IBOutlet var lblVerifOption: UILabel!
    @IBOutlet var btnVerifCall: UIButton!
    @IBOutlet var btnVerifMessage: UIButton!
    @IBOutlet var lblResend: UILabel!
    @IBOutlet var lblCounter: UILabel!
    @IBOutlet var lblChangePhone: UILabel!
    
    private var countdownTimer: Timer?
    private var secondsRemaining = 10
    private var isCounting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    private func setupUI() {
        btnBack.setTitle("", for: .normal)
        
        vToolbar.layer.shadowOpacity = 0.15
        vToolbar.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        vToolbar.layer.shadowRadius = 2.0
        
        lblToolbar.text = "Verifikasi"
        lblTitle.text = "Kode Verifikasi"
        lblDesc.text = "Silakan pilih metode untuk mendapatkan kode verifikasi."
        
        lblToolbar.font = Font.H1.font
        lblToolbar.textColor = UIColor.grey80
        
        lblTitle.font = Font.Display.D1.font
        lblTitle.textColor = UIColor.grey80
        
        lblDesc.font = Font.Paragraph.P1.Small.font
        lblDesc.textColor = UIColor.grey80
        
        let attrWA = NSAttributedString(string: "Verifikasi WhatsApp", attributes: [
            .font: Font.Button.Big.font,
            .foregroundColor: UIColor.white
        ])
        btnVerifWhatsapp.setAttributedTitle(attrWA, for: .normal)
        
        btnVerifWhatsapp.contentEdgeInsets = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
        btnVerifWhatsapp.backgroundColor = UIColor.Blue.blue30
        btnVerifWhatsapp.tintColor = UIColor.Blue.blue30
        btnVerifWhatsapp.layer.cornerRadius = 8
        
        lblVerifOption.text = "atau verifikasi dengan"
        lblVerifOption.font = Font.Body.B3.Small.font
        lblVerifOption.textColor = UIColor.grey50
        
        lblResend.text = "Kirim ulang kode verifikasi"
        lblResend.font = Font.Body.B3.Small.font
        lblResend.textColor = UIColor.Grey.grey50
        
        lblCounter.text = "00:30"
        lblCounter.font = Font.Body.B3.Large.font
        lblCounter.textColor = UIColor.Grey.grey80
        
        lblChangePhone.text = "Gant Nomor Handphone"
        lblChangePhone.font = Font.Button.Small.font
        lblChangePhone.textColor = UIColor.Blue.blue30
        
        startCountdownTimer()
        setupButton(isEnabled: false)
    }
    
    private func startCountdownTimer() {
        secondsRemaining = 10
        
        updateCounterLabel()
        
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc private func updateCounter() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            updateCounterLabel()
        } else {
            countdownTimer?.invalidate()
            enableVerificationButtons()
        }
    }
    
    private func updateCounterLabel() {
        lblCounter.text = "00:\(String(format: "%02d", secondsRemaining))"
    }
    
    private func enableVerificationButtons() {
        setupButton(isEnabled: true)
    }
    
    private func setupButton(isEnabled: Bool) {
        btnVerifCall.isEnabled = isEnabled
        btnVerifMessage.isEnabled = isEnabled
        
        let verifCall = btnVerifCall.title(for: .normal) ?? ""
        let verifMessage = btnVerifMessage.title(for: .normal) ?? ""
        
        if isEnabled {
            let attrCall = NSAttributedString(string: verifCall, attributes: [
                .font: Font.Button.Big.font,
                .foregroundColor: UIColor.Blue.blue30
            ])
            btnVerifCall.setAttributedTitle(attrCall, for: .normal)
            btnVerifCall.layer.borderColor = UIColor.Blue.blue30.cgColor
            
            let attrMessage = NSAttributedString(string: verifMessage, attributes: [
                .font: Font.Button.Big.font,
                .foregroundColor: UIColor.Blue.blue30
            ])
            btnVerifMessage.setAttributedTitle(attrMessage, for: .normal)
            btnVerifMessage.layer.borderColor = UIColor.Blue.blue30.cgColor
        } else {
            let attrCall = NSAttributedString(string: verifCall, attributes: [
                .font: Font.Button.Big.font,
                .foregroundColor: UIColor.Grey.grey30
            ])
            btnVerifCall.setAttributedTitle(attrCall, for: .normal)
            btnVerifCall.layer.borderColor = UIColor.Grey.grey30.cgColor
            
            let attrMessage = NSAttributedString(string: verifMessage, attributes: [
                .font: Font.Button.Big.font,
                .foregroundColor: UIColor.Grey.grey30
            ])
            btnVerifMessage.setAttributedTitle(attrMessage, for: .normal)
            btnVerifMessage.layer.borderColor = UIColor.Grey.grey30.cgColor
        }
        
        btnVerifCall.layer.borderWidth = 1
        btnVerifCall.layer.cornerRadius = 8
        btnVerifCall.clipsToBounds = true
        
        btnVerifMessage.layer.borderWidth = 1
        btnVerifMessage.layer.cornerRadius = 8
        btnVerifMessage.clipsToBounds = true
    }
    
    @IBAction func btnBack(_ sender: Any) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnWhatsapp(_ sender: Any) {
        if secondsRemaining <= 0 {
            startCountdownTimer()
        }
    }
}
