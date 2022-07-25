//
//  MainScreenViewController.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 25.07.2022.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainScreenTableViewCell.self, forCellReuseIdentifier: "AlbumCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let userInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        button.tintColor = UIColor(named: "totalWhite")
        button.addTarget(MainScreenViewController.self, action: #selector(userInfoButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var albums = [Album]()
    private var timer: Timer?
    
    //MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        fetchAlbums(albumName: "Trench")
    }
    
    //MARK: - Business logic
    
    @objc private func userInfoButtonTapped() {
        let userInfoViewController = UserInfoScreenViewController()
        navigationController?.pushViewController(userInfoViewController, animated: true)
    }
    
    private func fetchAlbums(albumName: String) {
        
        let urlString = "https://itunes.apple.com/search?term=\(albumName)&entity=album&attribute=albumTerm"
        
        NetworkManager.shared.fetchData(urlString: urlString) { [weak self] (result,error)  in
            
            if error == nil, let result = result {
                
                self?.albums = result
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}

//MARK: - TableView setup

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(named: "totalBlack")
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! MainScreenTableViewCell
        let album = albums[indexPath.row]
        cell.configureAlbumCell(album: album)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumDetailViewController = AlbumDetailScreenViewController()
        let album = albums[indexPath.row]
        albumDetailViewController.album = album
        albumDetailViewController.title = album.artistName
        navigationController?.present(albumDetailViewController, animated: true)
    }
}

//MARK: - NavigationBar setup

extension MainScreenViewController {
    
    private func setupNavigationBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Library"
        navigationItem.searchController = searchController
        
        let userInfoBarButton = UIBarButtonItem(customView: userInfoButton)
        navigationItem.rightBarButtonItem = userInfoBarButton
        
        let standardAppearance = UINavigationBarAppearance()
        
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "totalWhite")!]
        standardAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "totalWhite")!]
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor(named: "totalBlack")
        
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
        
        setupSearchController()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        if text != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                guard let self = self, let text = text else { return }
                self.fetchAlbums(albumName: text)
            })
        }
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = UIColor(named: "lightGreen")
        searchController.searchBar.searchTextField.textColor = UIColor(named: "lightGreen")
        searchController.obscuresBackgroundDuringPresentation = false
    }
}
