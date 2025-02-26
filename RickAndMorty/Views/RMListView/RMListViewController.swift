//
//  RMListViewController.swift
//  RickAndMorty
//
//  Created by Horacio Guzman on 11/06/23.
//

import UIKit
import Combine

protocol RMItemCell: UICollectionViewCell {
    func setup(viewModel: RMItemCellViewModel)
}

class RMItemCellViewModel: Hashable {
    
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
}

extension RMItemCellViewModel {
    
    static func ==(lhs: RMItemCellViewModel, rhs: RMItemCellViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

typealias RMListDataSource = UICollectionViewDiffableDataSource<Int, RMItemCellViewModel>
typealias RMListSnapshot = NSDiffableDataSourceSnapshot<Int, RMItemCellViewModel>

final class RMListViewController<A: Decodable, B: Configuration>: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: RMListDataSource!
    
    private let viewModel: RMListViewModel<A, B>
    private var actionCancellable: AnyCancellable?
    
    private var layout: UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    override func loadView() {
        super.loadView()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    init(viewModel: RMListViewModel<A, B>) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        configureBinding()
        viewModel.start()
    }
    
    private func configureBinding() {
        actionCancellable = viewModel.RMListViewModelActionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                switch action {
                case .setSnapshot(let snapshot):
                    self?.applySnapshot(snapshot: snapshot)
                }
            }
    }
    
    
}

// MARK: - CollectionView
extension RMListViewController {
    
    private func setupCollectionView() {
        collectionView.register(viewModel.cellType, forCellWithReuseIdentifier: viewModel.reuseID)
        collectionView.backgroundColor = .lightGray
        dataSource = RMListDataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
            self?.cellProvider(collectionView, indexPath, itemIdentifier)
        })
    }
    
    private func cellProvider(_ collectionView: UICollectionView,_ indexPath: IndexPath,_ itemIdentifier: RMItemCellViewModel) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.reuseID, for: indexPath) as? RMItemCell else {
            return nil
        }
        cell.setup(viewModel: itemIdentifier)
        return cell
    }
    
    private func applySnapshot(snapshot: RMListSnapshot) {
        dataSource.apply(snapshot)
    }
}
