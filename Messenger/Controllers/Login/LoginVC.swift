//
//  LoginVC.swift
//  Messenger
//
//  Created by developer on 6/18/22.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    private let totalScrollView = UIScrollView()
    
    private let totalView = UIView()
    
    private lazy var imageView : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "logo")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private lazy var emailField : UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Addres..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.delegate = self
        
        return field
    }()
    
    private lazy var passwordField : UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        field.delegate = self
        return field
    }()
    //
    private lazy var loginBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log In", for: .normal)
        btn.backgroundColor = .link
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20 , weight: .bold)
        btn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        return btn
    }()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Log In"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTappedChnageProfilePic))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gesture)
        
        
        setupViews()
        
        
    }
    //
    private func setupViews(){
 
        view.addSubview(totalScrollView)
        totalScrollView.addSubview(totalView)
        view.addSubview(imageView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginBtn)
        
        totalScrollView.anchor(.top(view.safeAreaLayoutGuide.topAnchor) , .bottom(view.safeAreaLayoutGuide.bottomAnchor), .leading(view.leadingAnchor) , .trailing(view.trailingAnchor))
        
        totalView.anchor(.top(totalScrollView.topAnchor), .bottom(totalScrollView.bottomAnchor), .width(view.frame.width))
        
        imageView.centerXTo(totalView.centerXAnchor)
        imageView.anchor(.width(view.frame.width / 3) , .height(view.frame.width / 3) , .top(totalView.topAnchor, constant: 15))
        
        emailField.anchor(.top(imageView.bottomAnchor, constant: 20) , .leading(totalView.leadingAnchor, constant: 20) , .trailing(totalView.trailingAnchor, constant: 20) , .height(52))
        
        passwordField.anchor(.top(emailField.bottomAnchor, constant: 20) , .leading(totalView.leadingAnchor, constant: 20) , .trailing(totalView.trailingAnchor, constant: 20) , .height(52))
        
        loginBtn.anchor(.top(passwordField.bottomAnchor, constant: 20) , .leading(totalView.leadingAnchor, constant: 20) , .trailing(totalView.trailingAnchor, constant: 20) , .height(52) , .bottom(totalView.bottomAnchor, constant: 15))
    }
    
    @objc private func didTapRegister(){
        let vc = RegisterVC()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func didTappedChnageProfilePic(){
        
        print("pic")
    }
    
    @objc private func loginBtnTapped(){
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let email = emailField.text , let password = passwordField.text ,
              !email.isEmpty, !password.isEmpty , password.count >= 6  else {
                  alertUserLoginError()
                  return
              }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult , error in
            guard let strongeSelf = self else{
                return
            }
            guard let result = authResult , error == nil else {
                print("faild to login user with email : \(email)")
                return
            }
            
            let user = result.user
            print("Logged in user : \(user)")
            strongeSelf.navigationController?.dismiss(animated: true, completion: nil)
        })
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all information to login",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

extension LoginVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }else if textField == passwordField {
            loginBtnTapped()
        }
        
        return true
    }
}
