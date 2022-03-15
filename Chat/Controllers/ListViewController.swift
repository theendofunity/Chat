//
//  ListCollectionViewController.swift
//  Chat
//
//  Created by Дмитрий Дудкин on 15.03.2022.
//

import UIKit
import SwiftUI

struct MChat: Hashable, Decodable {
    var username: String
    var userImageString: String
    var lastMessage: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.id == rhs.id
    }
}

class ListViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case waitingChats
        case activeChats
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, MChat>?
    var collectionView: UICollectionView!
    
    let activeChats: [MChat] = Bundle.main.decode(_type: [MChat].self, from: "activeChats.json")
    let waitingChats: [MChat] = Bundle.main.decode(_type: [MChat].self, from: "waitingChats.json")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
        
        setupDataSource()
        reloadData()
    }
    
    func setupCollectionView() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId2")
        collectionView!.register(ActiveChatCell.self, forCellWithReuseIdentifier: ActiveChatCell.reuseId)
        
        collectionView.backgroundColor = .mainWhite
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.addSubview(collectionView)
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
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MChat>()
        snapshot.appendSections([.waitingChats, .activeChats])
        snapshot.appendItems(waitingChats, toSection: .waitingChats)
        snapshot.appendItems(activeChats, toSection: .activeChats)

        dataSource?.apply(snapshot)
    }
}

// MARK: - DataSource

extension ListViewController {
    
    func configure<T: SelfConfiguringCell>(cellType: T.Type, chat: MChat, indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError()
        }
        cell.configure(with: chat)
        return cell
    }
    
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, MChat>(collectionView: collectionView, cellProvider: { collectionView, indexPath, chat in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError()
            }
            
            switch section {
            case .waitingChats:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId2", for: indexPath)
                cell.backgroundColor = .systemRed
                return cell
            case .activeChats:
                return self.configure(cellType: ActiveChatCell.self, chat: chat, indexPath: indexPath)
            }
        })
    }
}

// MARK: - Setup layout

extension ListViewController {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError()
            }
            
            switch section {
            case .waitingChats:
                return self.createWaitingChatsSection()
            case .activeChats:
                return self.createActiveChatsSection()
            }
        }
        return layout
    }
    
    func createActiveChatsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(78))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 16)
        return section
    }
    
    func createWaitingChatsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(88),
                                               heightDimension: .absolute(88))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 16)
        return section
    }
}

// MARK: - SearchBarDelegate

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

//MARK: - SwiftUI
struct ListViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = MainTabBarViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
