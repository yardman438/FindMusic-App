//
//  MainScreenTableViewCell.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 25.07.2022.
//

import UIKit
import SnapKit

class SearchTableViewCell: UITableViewCell {
    
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
        label.textColor = UIColor(named: "totalBlack")
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Artist"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "totalBlack")
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
        containerView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        containerView.addSubview(albumLogo)
        albumLogo.snp.makeConstraints { make in
            make.centerY.equalTo(containerView.snp.centerY)
            make.leading.equalTo(containerView.snp.leading)
            make.height.width.equalTo(120)
        }
        
        containerView.addSubview(albumNameLabel)
        albumNameLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.leading.equalTo(albumLogo.snp.trailing).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-15)
        }
        
        containerView.addSubview(artistNameLabel)
        artistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(albumNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(albumLogo.snp.trailing).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-15)
        }
        
        containerView.addSubview(trackCountLabel)
        trackCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumLogo.snp.trailing).offset(10)
            make.bottom.equalTo(containerView.snp.bottom).offset(-10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-15)
        }
    }
}
