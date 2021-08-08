//
//  ViewController.swift
//  Messenger
//
//  Created by James Thang on 07/08/2021.
//

import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemRed
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check if user already log in, if not present Log In View Controller
        let isLogIn = UserDefaults.standard.bool(forKey: "log_in")
        
        if !isLogIn {
            let vc = LogInViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false, completion: nil)
        }
    }

}

