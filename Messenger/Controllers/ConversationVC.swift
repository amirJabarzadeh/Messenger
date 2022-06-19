//
//  ViewController.swift
//  Messenger
//
//  Created by developer on 6/18/22.
//

import UIKit
import LBTATools
import FirebaseAuth

class ConversationVC : UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .white
        
        validateAuth()
        
        
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginVC()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
}

