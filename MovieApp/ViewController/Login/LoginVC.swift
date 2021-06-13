//
//  LoginVC.swift
//  MovieApp
//
//  Created by Tuan Le on 05/06/2021.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import NVActivityIndicatorView
import FBSDKLoginKit
import FBSDKCoreKit

class LoginVC: UIViewController {
    @IBOutlet weak var tftEmail: UITextField!
    @IBOutlet weak var tftPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnLoginGoogle: UIButton!
    @IBOutlet weak var btnLoginFacebook: UIButton!
    @IBOutlet weak var viewLogin: UIView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var viewParentLoading: UIView!
    @IBOutlet weak var viewLoading: NVActivityIndicatorView!
    var isShowPass: Bool = false
    let loginHelper = LoginHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboard()
    }
    
    func setupUI() {
        lblEmail.visibility = .gone
        lblPassword.visibility = .gone
        btnLogin.layer.cornerRadius = 8
        btnLoginGoogle.layer.cornerRadius = 5
        btnLoginFacebook.layer.cornerRadius = 5
        tftEmail.attributedPlaceholder = NSAttributedString(string: "Email",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hex: "FFFFFF")])
        tftPassword.attributedPlaceholder = NSAttributedString(string: "Password",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hex: "FFFFFF")])
        
    }
    
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let geture = UITapGestureRecognizer(target: self, action: #selector(tapView))
        view.addGestureRecognizer(geture)
    }
    
    @objc func tapView() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                lblEmail.visibility = .visible
                lblPassword.visibility = .visible
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            lblEmail.visibility = .gone
            lblPassword.visibility = .gone
        }
    }
    //ACTION
    @IBAction func register(_ sender: Any) {
        let vc = RegisterVC()
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func showPass(_ sender: Any) {
        if isShowPass {
            tftPassword.isSecureTextEntry = true
            isShowPass = false
        }
        else {
            tftPassword.isSecureTextEntry = false
            isShowPass = true
        }
    }
    @IBAction func forgotPassword(_ sender: Any) {
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func facebookLogin(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { result, error in
            if let error = error {
                print("failed to login fb")
                return
            }
            guard let accessToken = AccessToken.current else {
                print("get tokkent failed")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            Auth.auth().signIn(with: credential) { user, error in
                if let error = error {
                    print("login error: \(error.localizedDescription)")
                }
                else {
                    print("login success")
                }
            }
        }
    }
    
    @IBAction func login(_ sender: Any) {
        if validateData() {
            view.endEditing(true)
            viewParentLoading.isHidden = false
            viewLoading.startAnimating()
            viewLoading.type = .ballRotateChase
            loginHelper.login(email: tftEmail.text!, password: tftPassword.text!) { [self] isSuccess in
                viewParentLoading.isHidden = true
                if isSuccess {
                    let alert = UIAlertController(title: "Success", message: "Login success", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
                    }))
                    present(alert, animated: true, completion: nil)
                }
                else {
                    let alert = UIAlertController(title: "Error", message: "Login not success", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
                        tftEmail.text?.removeAll()
                        tftPassword.text?.removeAll()
                    }))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func validateData() -> Bool {
        guard let email = tftEmail.text else {
            showAlert(title: "Error", message: "Email is not valid")
            return false
        }
        guard let password = tftPassword.text else {
            showAlert(title: "Error", message: "Password is not valid")
            return false
        }
        if !isValidEmail(email) {
            showAlert(title: "Error", message: "Email is not valid")
            return false
        }
        if password.count<6 {
            showAlert(title: "Error", message: "Password is not valid")
            return false
        }
        return true
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

