//
//  RegisterVC.swift
//  Messenger
//
//  Created by developer on 6/18/22.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {
    
    private let totalScrollView = UIScrollView()
    
    private let totalView = UIView()
    
    private lazy var imageView : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "person.circle")
        img.tintColor = .systemGray
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.layer.cornerRadius = 50
        img.layer.borderWidth = 2
        img.layer.borderColor = UIColor.lightGray.cgColor
        return img
    }()
    
    private lazy var firsNameField : UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First Name..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.delegate = self
        
        return field
    }()
    
    private lazy var lastNameField : UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last Name..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.delegate = self
        
        return field
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
    
    private lazy var registerBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Register", for: .normal)
        btn.backgroundColor = .systemGreen
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20 , weight: .bold)
        btn.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Create Account"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTappedChnageProfilePic))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gesture)
        
        
        setupViews()
        
        
    }
    
    private func setupViews(){
        //AddSubView
        
        view.addSubview(totalScrollView)
        totalScrollView.addSubview(totalView)
        view.addSubview(imageView)
        view.addSubview(firsNameField)
        view.addSubview(lastNameField)
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerBtn)
        
        totalScrollView.anchor(.top(view.safeAreaLayoutGuide.topAnchor) , .bottom(view.safeAreaLayoutGuide.bottomAnchor), .leading(view.leadingAnchor) , .trailing(view.trailingAnchor))
        
        totalView.anchor(.top(totalScrollView.topAnchor), .bottom(totalScrollView.bottomAnchor), .width(view.frame.width))
        
        imageView.centerXTo(view.centerXAnchor)
        imageView.anchor(.width(100) , .height(100) , .top(totalView.topAnchor, constant: 15))
        
        firsNameField.anchor(.top(imageView.bottomAnchor, constant: 20) , .leading(totalView.leadingAnchor, constant: 20) , .trailing(totalView.trailingAnchor, constant: 20) , .height(52))
        
        lastNameField.anchor(.top(firsNameField.bottomAnchor, constant: 20) , .leading(totalView.leadingAnchor, constant: 20) , .trailing(totalView.trailingAnchor, constant: 20) , .height(52))
        
        emailField.anchor(.top(lastNameField.bottomAnchor, constant: 20) , .leading(totalView.leadingAnchor, constant: 20) , .trailing(totalView.trailingAnchor, constant: 20) , .height(52))
        
        passwordField.anchor(.top(emailField.bottomAnchor, constant: 20) , .leading(totalView.leadingAnchor, constant: 20) , .trailing(totalView.trailingAnchor, constant: 20) , .height(52))
        
        registerBtn.anchor(.top(passwordField.bottomAnchor, constant: 20) , .leading(totalView.leadingAnchor, constant: 20) , .trailing(totalView.trailingAnchor, constant: 20) , .height(52) , .bottom(totalView.bottomAnchor, constant: 15))
    }
    
    @objc private func didTapRegister(){
        let vc = RegisterVC()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc private func didTappedChnageProfilePic(){
        
        presentPhotoActionSheet()
        
    }
    
    
    
    @objc private func registerBtnTapped(){
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        firsNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        
        guard let firstName = firsNameField.text ,
              let lastName = lastNameField.text ,
              let email = emailField.text ,
              let password = passwordField.text ,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty ,
              password.count >= 6
                
        else {
            alertUserRegisterError()
            return
        }
        
        DatabaseManager.shared.userExists(with: email, completion: {[weak self] exists in
            guard let strongeSelf = self else{
                return
            }
            
            guard !exists else {
                strongeSelf.alertUserRegisterError(message: "Look like a user ccount for that email address alredy exists")
                return
            }
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult , error in
           
                guard authResult == nil , error == nil else {
                    print("Error creating user")
                    return
                }
                
                DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: firstName,
                                                                    lastName: lastName,
                                                                    emailAddress: email))
                
                strongeSelf.navigationController?.dismiss(animated: true, completion: nil)

            })
            
        })
        

    }
    
    func alertUserRegisterError(message:String = "Please enter all information to create a new account" ) {
        let alert = UIAlertController(title: "Woops",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension RegisterVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }else if textField == passwordField {
            registerBtnTapped()
        }
        
        return true
    }
}

extension RegisterVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like select a picture?",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: {[weak self] _ in
            self?.presentCamera()
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Chose Photo",
                                            style: .default,
                                            handler: {[weak self] _ in
            self?.presentPhotoPicker()
            
        }))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = .camera
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        let selectedImage = info[UIImagePickerController.InfoKey.editedImage]
        imageView.image = selectedImage as? UIImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
