//
//  SignUpScreenViewController.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 26.07.2022.
//

import UIKit

class SignUpScreenViewController: UIViewController {
    
    var signUpScreenView = SignUpScreenView()
    
    //Valid types for checking the input information
    let nameValidType: String.ValidTypes = .name
    let emailValidType: String.ValidTypes = .email
    let passwordValidType: String.ValidTypes = .password
    
    //MARK: - ViewController lifecycle
    
    override func loadView() {
        view = signUpScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpScreenView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        setupDelegate()
        registerKeybordNotification()
    }
    
    deinit {
        removeKeybordNotification()
    }
    
    //MARK: - Business logic
    
    @objc private func signUpButtonTapped() {
        
        let firstNameText = signUpScreenView.firstNameStackView.textField.text ?? ""
        let secondNameText = signUpScreenView.secondNameStackView.textField.text ?? ""
        let phoneText = signUpScreenView.phoneStackView.textField.text ?? ""
        let emailText = signUpScreenView.emailStackView.textField.text ?? ""
        let passwordText = signUpScreenView.passwordStackView.textField.text ?? ""
        
        if firstNameText.isValid(validType: nameValidType)
            && secondNameText.isValid(validType: nameValidType)
            && emailText.isValid(validType: emailValidType)
            && passwordText.isValid(validType: passwordValidType)
            && phoneText.count == 19
            && ageIsValid() == true {
            
            print("+")
            UserDefaultsManager.shared.saveUser(firstName: firstNameText, secondName: secondNameText, age: signUpScreenView.datePicker.date, phone: phoneText, email: emailText, password: passwordText)
            alertOk(title: "Success", message: "Your profile is saved")
        } else {
            print("-")
            alertOk(title: "Failed", message: "Your profile must contain filled required fields")
        }
        
    }
    
    //The main func to setup text in text fields and checking required rules for input text
    private func setTextField(textField: UITextField, label: UILabel, validType: String.ValidTypes, validMessage: String, wrongMessage: String, string: String, range: NSRange) {
        
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1{
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        
        if result.isValid(validType: validType) {
            label.text = validMessage
            label.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        } else {
            label.text = wrongMessage
            label.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
    }
    
    //Setup a mask for phone numbers in text field and checking required rules
    private func setPhoneNumberMask(textField: UITextField, mask: String, string: String, range: NSRange) -> String {
        
        let text = textField.text ?? ""
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        
        if result.count == 19 {
            signUpScreenView.phoneStackView.validLabel.text = "Phone number is valid"
            signUpScreenView.phoneStackView.validLabel.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        } else {
            signUpScreenView.phoneStackView.validLabel.text = "Phone number is not valid"
            signUpScreenView.phoneStackView.validLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
        
        return result
    }
    
    //Setup checking required age rules
    private func ageIsValid() -> Bool {
        let calendar = NSCalendar.current
        let dateNow = Date()
        let birthday = signUpScreenView.datePicker.date
        
        let age = calendar.dateComponents([.year], from: birthday, to: dateNow)
        let ageYear = age.year
        guard let ageUser = ageYear else { return false }
        return (ageUser < 18 ? false : true)
    }
    
}

//MARK: - UITextField delegate

extension SignUpScreenViewController: UITextFieldDelegate {
    
    private func setupDelegate() {
        signUpScreenView.firstNameStackView.textField.delegate = self
        signUpScreenView.secondNameStackView.textField.delegate = self
        signUpScreenView.phoneStackView.textField.delegate = self
        signUpScreenView.emailStackView.textField.delegate = self
        signUpScreenView.passwordStackView.textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        signUpScreenView.firstNameStackView.textField.resignFirstResponder()
        signUpScreenView.secondNameStackView.textField.resignFirstResponder()
        signUpScreenView.phoneStackView.textField.resignFirstResponder()
        signUpScreenView.emailStackView.textField.resignFirstResponder()
        signUpScreenView.passwordStackView.textField.resignFirstResponder()
        return true
    }
    
    //The main func to determine correct text fields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case signUpScreenView.firstNameStackView.textField:
            setTextField(textField: signUpScreenView.firstNameStackView.textField,
                         label: signUpScreenView.firstNameStackView.validLabel,
                         validType: nameValidType,
                         validMessage: "Name is valid",
                         wrongMessage: "Only A-Z characters, min 1 character",
                         string: string,
                         range: range)
        case signUpScreenView.secondNameStackView.textField:
            setTextField(textField: signUpScreenView.secondNameStackView.textField,
                         label: signUpScreenView.secondNameStackView.validLabel,
                         validType: nameValidType,
                         validMessage: "Name is valid",
                         wrongMessage: "Only A-Z characters, min 1 character",
                         string: string,
                         range: range)
        case signUpScreenView.emailStackView.textField:
            setTextField(textField: signUpScreenView.emailStackView.textField,
                         label: signUpScreenView.emailStackView.validLabel,
                         validType: emailValidType,
                         validMessage: "Email is valid",
                         wrongMessage: "Email is not valid ",
                         string: string,
                         range: range)
        case signUpScreenView.passwordStackView.textField:
            setTextField(textField: signUpScreenView.passwordStackView.textField,
                         label: signUpScreenView.passwordStackView.validLabel,
                         validType: passwordValidType,
                         validMessage: "Password is valid",
                         wrongMessage: "Password is not valid ",
                         string: string,
                         range: range)
        case signUpScreenView.phoneStackView.textField:
            signUpScreenView.phoneStackView.textField.text = setPhoneNumberMask(textField: signUpScreenView.phoneStackView.textField,
                                                                                mask: "+XX (XXX) XXX-XX-XX",
                                                                                string: string,
                                                                                range: range)
        default:
            break
        }
        
        return false
    }
}

//MARK: - Keybord show/hide

extension SignUpScreenViewController {
    
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
        signUpScreenView.scrollView.contentOffset = CGPoint(x: 0, y: keybordHeight.height / 2)
    }
    
    @objc private func keybordWillHide() {
        signUpScreenView.scrollView.contentOffset = CGPoint.zero
    }
}
