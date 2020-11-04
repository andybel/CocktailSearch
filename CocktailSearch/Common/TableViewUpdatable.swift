//
//  Created by Andy Bell on 18.10.20.
//

import UIKit

enum Section: CaseIterable {
    case main
}

protocol TableViewUpdatable {
    func updateDataSource<T>(_ dataSource: UITableViewDiffableDataSource<Section, T>, withItems items: [T], animated: Bool)
}

extension TableViewUpdatable where Self: UIViewController {
    
    func updateDataSource<T>(_ dataSource: UITableViewDiffableDataSource<Section, T>, withItems items: [T], animated: Bool) {

        var snapshot = NSDiffableDataSourceSnapshot<Section, T>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}
