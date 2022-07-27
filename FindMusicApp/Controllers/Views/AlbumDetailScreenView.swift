//
//  AlbumDetailScreenView.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 25.07.2022.
//

import UIKit
import SnapKit

class AlbumDetailScreenView: UIView {

    let albumLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "emptyAlbumLogo")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(named: "totalBlack")?.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Album name"
        label.textColor = UIColor(named: "totalWhite")
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Artist"
        label.textColor = UIColor(named: "totalWhite")
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Release date"
        label.textColor = UIColor(named: "totalWhite")
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let trackCountLabel: UILabel = {
        let label = UILabel()
        label.text = "16 tracks"
        label.textColor = UIColor(named: "brightBlue")
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "totalWhite")
        button.tintColor = UIColor(named: "totalBlack")
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "brightBlue")
        button.tintColor = UIColor(named: "totalWhite")
        button.setTitle("More", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        
        self.addSubview(albumLogo)
        albumLogo.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(80)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.height.width.equalTo(150)
        }
        
        self.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.height.width.equalTo(40)
        }
        
        self.addSubview(moreButton)
        moreButton.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(60)
        }

        stackView = UIStackView(arrangedSubviews: [albumNameLabel, artistNameLabel, releaseDateLabel, trackCountLabel],
                                axis: .vertical,
                                spacing: 10,
                                distribution: .equalCentering)
        stackView.alignment = .leading
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(80)
            make.leading.equalTo(albumLogo.snp.trailing).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(150)
        }
    }
}
