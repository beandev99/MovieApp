//
//  RegisterVC.swift
//  MovieApp
//
//  Created by Tuan Le on 06/06/2021.
//

import UIKit
import NVActivityIndicatorView

class RegisterVC: UIViewController {
    @IBOutlet weak var collectionSignUp: UICollectionView!
    @IBOutlet weak var viewLoading: NVActivityIndicatorView!
    @IBOutlet weak var viewParentLoading: UIView!
    let REGISTER_CELL = "RegisterCell"
    let REGISTER_CELL_SIGN_UP = "RegisterCellSignUp"
    var dataRegiser: [RegisterModel] = []
    let registerHelper = RegisterHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
        viewLoading.startAnimating()
        viewLoading.type = .ballRotateChase
    }
    
    func setupUI() {
        collectionSignUp.delegate = self
        collectionSignUp.dataSource = self
        collectionSignUp.register(UINib(nibName: REGISTER_CELL, bundle: nil), forCellWithReuseIdentifier: REGISTER_CELL)
        collectionSignUp.register(UINib(nibName: REGISTER_CELL_SIGN_UP, bundle: nil), forCellWithReuseIdentifier: REGISTER_CELL_SIGN_UP)
        collectionSignUp.showsVerticalScrollIndicator = false
        let geture = UITapGestureRecognizer(target: self, action: #selector(tapView))
        view.addGestureRecognizer(geture)
    }
    
    @objc func tapView(){
        view.endEditing(true)
    }
    
    func setupData() {
        dataRegiser.append(RegisterModel(nameInput: "Email Address", imgName: "ic-email", txtHint: "tuanlt.ptit@gmail.com"))
        dataRegiser.append(RegisterModel(nameInput: "Phone Number", imgName: "ic-phone", txtHint: "tuanlt.ptit@gmail.com"))
        dataRegiser.append(RegisterModel(nameInput: "Password", imgName: "ic-password", txtHint: "tuanlt.ptit@gmail.com"))
        dataRegiser.append(RegisterModel(nameInput: "Confirm Password", imgName: "ic-password", txtHint: "tuanlt.ptit@gmail.com"))
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension RegisterVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataRegiser.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < dataRegiser.count {
            if let cell = collectionSignUp.dequeueReusableCell(withReuseIdentifier: REGISTER_CELL, for: indexPath) as? RegisterCell {
                cell.btnExpand.visibility = .invisible
                cell.lblTitile.text = dataRegiser[indexPath.row].nameInput
                cell.btnImgDetail.setImage(UIImage(named: dataRegiser[indexPath.row].imgName), for: .normal)
                cell.tftInput.attributedPlaceholder = NSAttributedString(string: dataRegiser[indexPath.row].txtHint,
                                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hex: "7C7D7F")])
                if indexPath.row == 2 || indexPath.row == 3 {
                    cell.tftInput.isSecureTextEntry = true
                }
                else {
                    cell.tftInput.isSecureTextEntry = false
                }
                if indexPath.row == 1 {
                    cell.tftInput.keyboardType = .phonePad
                }
                else {
                    cell.tftInput.keyboardType = .default
                }
                return cell
            }
        }
        else {
            if let cell = collectionSignUp.dequeueReusableCell(withReuseIdentifier: REGISTER_CELL_SIGN_UP, for: indexPath) as? RegisterCellSignUp {
                cell.delgate = self
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = collectionSignUp.frame.size.width
        var heightCell: CGFloat = 0
        if indexPath.row == dataRegiser.count {
            heightCell = collectionSignUp.frame.height/4
        }
        else {
            heightCell = collectionSignUp.frame.height/8.8
            
        }
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
extension RegisterVC: SignUpDelegate {
    func signUp() {
        if validateData().isSuccess {
            viewLoading.startAnimating()
            viewLoading.type = .ballRotateChase
            viewParentLoading.isHidden = false
            
            guard let email = validateData().email else {return}
            guard let password = validateData().password else {return}
            registerHelper.register(email: email, password: password) { [self] isSuccess in
                viewLoading.stopAnimating()
                viewParentLoading.isHidden = true
                if isSuccess {
                    let alert = UIAlertController(title: "Success", message: "Register success", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    present(alert, animated: true, completion: nil)
                }
                else {
                    let alert = UIAlertController(title: "Error", message: "Register not success", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
extension RegisterVC {
    func validateData() -> (isSuccess: Bool, email: String?, password: String?) {
        if !validateEmail().isSuccess {return (false,nil,nil)}
        let email = validateEmail().email
        if !validatePhoneNumber().isSuccess {return (false,nil,nil)}
        if !vaidatePassword().isSuccess {return (false,nil,nil)}
        let password = vaidatePassword().password
        return (true, email, password)
    }
    
    func validateEmail() -> (isSuccess: Bool,email: String?) {
        let cellAddress = collectionSignUp.cellForItem(at: IndexPath(row: 0, section: 0)) as? RegisterCell
        let emailAddress = cellAddress?.tftInput.text
        guard let emailAddress = emailAddress else {
            showAlert(title: "Error", message: "Email is not empty")
            return (false,nil)
        }
        if !isValidEmail(emailAddress) {
            showAlert(title: "Error", message: "Email is not valid")
            return (false,nil)
        }
        return (true,emailAddress)
    }
    
    func validatePhoneNumber() -> (isSuccess: Bool, phoneNumber: String?) {
        let cellPhoneNumber = collectionSignUp.cellForItem(at: IndexPath(row: 1, section: 0)) as? RegisterCell
        let phoneNumber = cellPhoneNumber?.tftInput.text
        guard let phoneNumber = phoneNumber else {
            showAlert(title: "Error", message: "Phone number is not empty")
            return (false,nil)
        }
        if phoneNumber.count<10{
            showAlert(title: "Error", message: "Phone number is not valid")
            return (false,nil)
        }
        return (true,phoneNumber)
    }
    
    func vaidatePassword() -> (isSuccess: Bool, password: String?) {
        let cellPassWord = collectionSignUp.cellForItem(at: IndexPath(row: 2, section: 0)) as? RegisterCell
        let cellRepeatPassWord = collectionSignUp.cellForItem(at: IndexPath(row: 3, section: 0)) as? RegisterCell
        let password = cellPassWord?.tftInput.text
        let repeatPassword = cellRepeatPassWord?.tftInput.text
        guard let password = password else {
            showAlert(title: "Error", message: "Password is not empty")
            return (false,nil)
        }
        if password.count < 6 {
            showAlert(title: "Error", message: "Password phai >= 6 ky tu")
            return (false,nil)
        }
        guard let repeatPassword = repeatPassword else {
            showAlert(title: "Error", message: "Repeat password phai giong password")
            return (false,nil)
        }
        if password != repeatPassword {
            showAlert(title: "Error", message: "Repeat password phai giong password")
            return (false,nil)
        }
        return (true,password)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

