//
//  AlbumDetailScreenView.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 25.07.2022.
//

import UIKit

class AlbumDetailScreenView: UIView {

    let albumLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.image = UIImage(named: "emptyAlbumLogo")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(named: "totalBlack")?.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Album name"
        label.textColor = UIColor(named: "totalWhite")
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Artist"
        label.textColor = UIColor(named: "totalWhite")
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Release date"
        label.textColor = UIColor(named: "totalWhite")
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let trackCountLabel: UILabel = {
        let label = UILabel()
        label.text = "16 tracks"
        label.textColor = UIColor(named: "brightBlue")
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
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
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        
        self.addSubview(albumLogo)
        self.addSubview(backButton)
        self.addSubview(moreButton)
        

        stackView = UIStackView(arrangedSubviews: [albumNameLabel, artistNameLabel, releaseDateLabel, trackCountLabel],
                                axis: .vertical,
                                spacing: 10,
                                distribution: .equalCentering)
        stackView.alignment = .center
        self.addSubview(stackView)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            albumLogo.topAnchor.constraint(equalTo: self.topAnchor),
            albumLogo.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            albumLogo.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            albumLogo.heightAnchor.constraint(equalToConstant: self.bounds.width)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: albumLogo.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: self.bounds.width),
            albumNameLabel.widthAnchor.constraint(equalToConstant: 320)
        ])
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            moreButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            moreButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            moreButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            moreButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
