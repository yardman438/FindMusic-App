//
//  LoginScreenViewController.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 25.07.2022.
//

import UIKit

class LoginScreenViewController: UIViewController {
    
    var loginScreenView = LoginScreenView()
    
    //MARK: - ViewController lifecycle
    
    override func loadView() {
        view = loginScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupInterface()
        registerKeybordNotification()
    }
    
    deinit {
        removeKeybordNotification()
    }
    
    //MARK: - Business logic
    
    @objc private func signInButtonTapped() {
        //
        //        let email = emailTextField.text ?? ""
        //        let password = passwordTextField.text ?? ""
        //        let user = findUser(email: email)
        //
        //        if user == nil {
        //
        //            loginLabel.text = "User is not found"
        //            loginLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        //
        //        } else if user?.password == password {
        //
        //            let navigationController = UINavigationController(rootViewController: AlbumsViewController())
        //            navigationController.modalPresentationStyle = .fullScreen
        //            self.present(navigationController, animated: true)
        //
        //            guard let activeUser = user else { return }
        //            DBService.shared.saveActiveUser(user: activeUser)
        //
        //        } else {
        //
        //            loginLabel.text = "Incorrect password"
        //            loginLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        //
        //        }
        let navigationController = UINavigationController(rootViewController: MainScreenViewController())
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true)
    }
    
    @objc private func signUpButtonTapped() {
//        let signUpViewController = SignUpScreenViewController()
//        self.present(signUpViewController, animated: true)
    }
    
    private func findUser(email: String) -> User? {
        let dbService = UserDefaultsManager.shared.users
        print(dbService)
        
        for user in dbService {
            if user.email == email {
                return user
            }
        }
        
        return nil
    }
}

//MARK: - UITextField delegate

extension LoginScreenViewController: UITextFieldDelegate {
    
    private func setupDelegate() {
        loginScreenView.emailTextField.delegate = self
        loginScreenView.passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginScreenView.emailTextField.resignFirstResponder()
        loginScreenView.passwordTextField.resignFirstResponder()
        return true
    }
}

//MARK: - Keybord show/hide

extension LoginScreenViewController {
    
    private func registerKeybordNotification() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keybordWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keybordWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeKeybordNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keybordWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keybordHeight = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        loginScreenView.scrollView.contentOffset = CGPoint(x: 0, y: keybordHeight.height / 2)
    }
    
    @objc private func keybordWillHide() {
        loginScreenView.scrollView.contentOffset = CGPoint.zero
    }
}

//MARK: - Setup interface

extension LoginScreenViewController {
    
    //The main func for an interface setup
    private func setupInterface() {
        title = "Login"
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: "totalBlack")
        loginScreenView.signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        loginScreenView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
}

