//
//  CustomStackView.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 26.07.2022.
//

import UIKit

class CustomStackView: UIStackView {
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your first name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let validLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.textColor = UIColor(named: "totalWhite")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(placeholder: String, isSecure: Bool) {
        self.init(frame: .zero)
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        self.addArrangedSubview(textField)
        self.addArrangedSubview(validLabel)
        self.axis = .vertical
        self.spacing = 3
        self.distribution = .equalCentering
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
