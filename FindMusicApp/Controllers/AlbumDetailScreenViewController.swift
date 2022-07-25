//
//  AlbumDetailScreenViewController.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 25.07.2022.
//

import UIKit

class AlbumDetailScreenViewController: UIViewController {
    
    var albumDetailView = AlbumDetailScreenView()
    
    var album: Album?
    
    override func loadView() {
        view = albumDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
        setAlbum()
    }
    
    @objc private func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func moreButtonTapped() {
        
    }
    
    private func setAlbum() {
        
        guard let album = album else { return }
        
        if let urlString = album.artworkUrl100 {
            
            NetworkManagerRequest.shared.setRequest(urlString: urlString) { [weak self] (result) in
                
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.albumDetailView.albumLogo.image = image
                case .failure(let error):
                    self?.albumDetailView.albumLogo.image = UIImage(named: "emptyAlbumLogo")
                    print("No album logo + \(error.localizedDescription)")
                }
            }
        } else {
            albumDetailView.albumLogo.image = UIImage(named: "emptyAlbumLogo")
        }
        
        albumDetailView.albumNameLabel.text = album.collectionName.uppercased()
        albumDetailView.artistNameLabel.text = "by \(album.artistName)"
        albumDetailView.releaseDateLabel.text = setDateFormat(date: album.releaseDate)
        albumDetailView.trackCountLabel.text = "\(album.trackCount) tracks"
    }
    
    private func setDateFormat(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let backendDate = dateFormatter.date(from: date) else { return ""}
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd-MM-yyyy"
        let dateString = formatDate.string(from: backendDate)
        
        return dateString
    }
    
    private func setupInterface() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: "totalBlack")
        albumDetailView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        albumDetailView.moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
}
