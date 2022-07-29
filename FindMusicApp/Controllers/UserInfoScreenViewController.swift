//
//  UserInfoScreenViewController.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 25.07.2022.
//

import UIKit
import SnapKit

class UserInfoScreenViewController: UIViewController {
    
    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First name:"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: "totalWhite")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Second name:"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: "totalWhite")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Age:"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: "totalWhite")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: "totalWhite")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone number:"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: "totalWhite")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
        setUserInfo()
    }
    
    private func setUserInfo() {
        
        guard let activeUser = UserDefaultsManager.shared.activeUser else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: activeUser.age)
        
        firstNameLabel.text = "First name: \(activeUser.firstName)"
        secondNameLabel.text = "Second name: \(activeUser.secondName)"
        ageLabel.text = "Age: \(dateString)"
        phoneLabel.text = "Phone number: \(activeUser.phone)"
        emailLabel.text = "Email: \(activeUser.email)"
    }
}

extension UserInfoScreenViewController {
    
    private func setupInterface() {
        title = "UserInfo"
        view.backgroundColor = UIColor(named: "totalBlack")
        
        stackView = UIStackView(arrangedSubviews: [firstNameLabel, secondNameLabel, ageLabel, phoneLabel, emailLabel],
                                axis: .vertical,
                                spacing: 10,
                                distribution: .fillProportionally)
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(20)
        }
    }
}
