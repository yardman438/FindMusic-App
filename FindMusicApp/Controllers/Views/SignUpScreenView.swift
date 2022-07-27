//
//  SignUpScreenView.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 26.07.2022.
//

import UIKit
import SnapKit

class SignUpScreenView: UIView {
    
    private let screenSize = UIScreen.main.bounds.size
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "REGISTRATION"
        label.textColor = UIColor(named: "totalWhite")
        label.font = .systemFont(ofSize: 36, weight: .medium)
        label.textAlignment = .center
        label.addCharacterSpacing(kernValue: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let firstNameStackView = CustomStackView(placeholder: "Enter your first name", isSecure: false)
    let secondNameStackView = CustomStackView(placeholder: "Enter your second name", isSecure: false)
    
    let datePicker = UIDatePicker()
    
    let ageValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.textColor = UIColor(named: "totalWhite")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneStackView = CustomStackView(placeholder: "Enter your phone", isSecure: false)
    let emailStackView = CustomStackView(placeholder: "Enter your email", isSecure: false)
    let passwordStackView = CustomStackView(placeholder: "Enter your password", isSecure: true)
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "brightYellow")
        button.tintColor = UIColor(named: "totalBlack")
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var mainStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        
        self.backgroundColor = UIColor(named: "totalBlack")
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
        }
        
        //signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
//        self.addSubview(scrollView)
//        scrollView.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(30)
//            make.leading.bottom.trailing.equalTo(self.safeAreaLayoutGuide)
//        }
//
//        scrollView.addSubview(backgroundView)
//        backgroundView.snp.makeConstraints { make in
//            make.top.leading.bottom.trailing.equalTo(scrollView)
//        }
        
        mainStackView = UIStackView(arrangedSubviews: [firstNameStackView,
                                                       secondNameStackView,
                                                       datePicker,
                                                       ageValidLabel,
                                                       phoneStackView,
                                                       emailStackView,
                                                       passwordStackView,
                                                       signUpButton],
                                    axis: .vertical,
                                    spacing: 16,
                                    distribution: .fillProportionally)
        
//        backgroundView.addSubview(mainStackView)
//        mainStackView.snp.makeConstraints { make in
//            make.centerX.equalTo(backgroundView.snp.centerX)
//            make.leading.equalTo(backgroundView.snp.leading).offset(20)
//            make.trailing.equalTo(backgroundView.snp.trailing).offset(-20)
//            make.width.equalTo(screenSize.width - 40)
//        }
        self.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.width.equalTo(screenSize.width - 40)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.layer.borderColor = UIColor.white.cgColor
        datePicker.layer.borderWidth = 1
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 6
        datePicker.tintColor = .black
    }
}
