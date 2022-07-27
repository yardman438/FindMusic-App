//
//  LoginScreenView.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 25.07.2022.
//

import UIKit
import SnapKit

class LoginScreenView: UIView {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        label.text = "WELCOME TO MUSIC LIBRARY"
        label.textColor = UIColor(named: "totalWhite")
        label.font = .systemFont(ofSize: 36, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.addCharacterSpacing(kernValue: 6)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        let blackPlaceholderText = NSAttributedString(string: "Enter your email",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "darkGrey")!])
        textField.attributedPlaceholder = blackPlaceholderText
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        let blackPlaceholderText = NSAttributedString(string: "Enter your password",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "darkGrey")!])
        textField.attributedPlaceholder = blackPlaceholderText
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "brightBlue")
        button.tintColor = UIColor(named: "totalWhite")
        button.setTitle("Sign in", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "lightGreen")?.cgColor
        button.tintColor = UIColor(named: "lightGreen")
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var textFieldsStackView = UIStackView()
    var buttonsStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(scrollView.safeAreaLayoutGuide)
        }
        
        textFieldsStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField],
                                          axis: .vertical,
                                          spacing: 10,
                                          distribution: .fillEqually)
        backgroundView.addSubview(textFieldsStackView)
        textFieldsStackView.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundView.snp.centerY)
            make.leading.equalTo(backgroundView.snp.leading).offset(20)
            make.trailing.equalTo(backgroundView.snp.trailing).offset(-20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        backgroundView.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.leading.equalTo(backgroundView.snp.leading).offset(20)
            make.trailing.equalTo(backgroundView.snp.trailing).offset(-20)
            make.bottom.equalTo(textFieldsStackView.snp.top).offset(-40)
        }

        buttonsStackView = UIStackView(arrangedSubviews: [signInButton, signUpButton],
                                       axis: .vertical,
                                       spacing: 10,
                                       distribution: .fillEqually)
        backgroundView.addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(textFieldsStackView.snp.bottom).offset(20)
            make.leading.equalTo(backgroundView.snp.leading).offset(20)
            make.trailing.equalTo(backgroundView.snp.trailing).offset(-20)
        }

        signInButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
}
