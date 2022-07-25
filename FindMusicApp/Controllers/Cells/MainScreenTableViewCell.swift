//
//  MainScreenTableViewCell.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 25.07.2022.
//

import UIKit

class MainScreenTableViewCell: UITableViewCell {
    
    //MARK: - Interface elements init
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "totalWhite")
        view.layer.borderColor = UIColor(named: "lightGreen")?.cgColor
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 2
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let albumLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "totalWhite")
        imageView.image = UIImage(named: "emptyAlbumLogo")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Album name"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Artist"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let trackCountLabel: UILabel = {
        let label = UILabel()
        label.text = "16 tracks"
        label.textColor = UIColor(named: "brightBlue")
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - TableViewCell lifecycle
    
    override open var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.size.height -= 5
            super.frame = frame
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Interface
    
    func configureAlbumCell(album: Album) {
        
        if let urlString = album.artworkUrl100 {
            
            NetworkManagerRequest.shared.setRequest(urlString: urlString) { [weak self] (result) in
                
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.albumLogo.image = image
                case .failure(let error):
                    self?.albumLogo.image = UIImage(named: "emptyAlbumLogo")
                    print("No album logo + \(error.localizedDescription)")
                }
            }
        } else {
            albumLogo.image = UIImage(named: "emptyAlbumLogo")
        }
                
        albumNameLabel.text = album.collectionName
        artistNameLabel.text = "by \(album.artistName)"
        trackCountLabel.text = "\(album.trackCount) tracks"
    }
    
    private func setupCellView() {
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.addSubview(containerView)
        containerView.addSubview(albumLogo)
        containerView.addSubview(albumNameLabel)
        containerView.addSubview(artistNameLabel)
        containerView.addSubview(trackCountLabel)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            albumLogo.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            albumLogo.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            albumLogo.heightAnchor.constraint(equalToConstant: 120),
            albumLogo.widthAnchor.constraint(equalToConstant: 110)
        ])
        
        NSLayoutConstraint.activate([
            albumNameLabel.leadingAnchor.constraint(equalTo: albumLogo.trailingAnchor, constant: 10),
            albumNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            albumNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            artistNameLabel.leadingAnchor.constraint(equalTo: albumLogo.trailingAnchor, constant: 10),
            artistNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            trackCountLabel.leadingAnchor.constraint(equalTo: albumLogo.trailingAnchor, constant: 10),
            trackCountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            trackCountLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }
}
