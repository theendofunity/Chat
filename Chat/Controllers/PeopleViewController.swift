//
//  PeaopleViewController.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 15.03.2022.
//

import UIKit
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class PeopleViewController: UIViewController {
    enum Section: Int, CaseIterable {
        case users
        
        func description(usersCount: Int) -> String {
            switch self {
            case .users:
                return "\(usersCount) people nerby"
            }
        }
    }
    
    var users: [MUser] = []
    
    var collectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, MUser>! = nil
    
    private let currentUser: MUser
    private var listener: ListenerRegistration?
    
    init(currentUser: MUser) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        self.title = currentUser.username
    }
    
    deinit {
        listener?.remove()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        setupSearchBar()
        setupNavigationBar()
        
        setupCollectionView()
        setupDataSource()
        
        listener = ListenerService.shared.usersObserve(users: users, completion: { result in
            switch result {
            case .success(let users):
                self.users = users
                self.reloadData(with: nil)
            case .failure(let error):
                self.showError(error: error)
            }
        })
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signOut))
    }

    func setupSearchBar() {
        navigationController?.navigationBar.backgroundColor = .mainWhite
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
    }
    
    func setupCollectionView() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseId)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        collectionView.backgroundColor = .mainWhite
        collectionView.delegate = self
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.addSubview(collectionView)
    }
    
    func reloadData(with name: String?) {
        let filtered = users.filter {
            $0.contains(filter: name)
        }
        var snapshot = NSDiffableDataSourceSnapshot<Section, MUser>()
        snapshot.appendSections([.users])
        snapshot.appendItems(filtered, toSection: .users)
        dataSource?.apply(snapshot)
    }
    
    @objc func signOut() {
        let alert = UIAlertController(title: nil, message: "Are you sure to sign out?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let signOutAction = UIAlertAction(title: "Sign out", style: .destructive) {_ in
            do {
                try Auth.auth().signOut()
                UIApplication.shared.keyWindow?.rootViewController = AuthViewController()
            } catch {
                
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(signOutAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Setup data source

extension PeopleViewController {
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, MUser>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError()
            }
            switch section {
            case .users:
                return self.configure(cellType: UserCell.self, value: item, indexPath: indexPath)
            }
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader
            else {
                fatalError()
            }
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError()
            }
            let items = self.dataSource.snapshot().itemIdentifiers(inSection: .users)
            header.configure(text: section.description(usersCount: items.count), font: .systemFont(ofSize: 36), textColor: .label)
            return header
        }
    }
    
    func configure<T: SelfConfiguringCell, U: Hashable>(cellType: T.Type, value: U, indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError()
        }
        cell.configure(with: value)
        return cell
    }
}

// MARK: - Setup layout

extension PeopleViewController {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError()
            }
            
            switch section {
            case .users:
                return self.createUsersSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        layout.configuration = config
        
        return layout
    }
    
    func createUsersSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing: CGFloat = 16
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
        
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return sectionHeader
    }
}

// MARK: - SearchBarDelegate

extension PeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reloadData(with: searchText)
    }
}

//MARK: - UICollectionViewDelegate

extension PeopleViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let user = self.dataSource.itemIdentifier(for: indexPath) else { return }
        let profileViewController = ProfileViewController(user: user)
        present(profileViewController, animated: true)
    }
}
