//
//  SectionedListView.swift
//  tableview-extension
//
//  Created by Juan Carlos Ospina Gonzalez on 21/02/2019.
//  Copyright © 2019 Juan Carlos Ospina Gonzalez. All rights reserved.
//

import Foundation
import UIKit

protocol SectionedListView: AbsoluteIndexProvider {
    func numberOfSections() -> Int
    func numberOfItems(inSection section: Int) -> Int
    func indexPathIsInBounds(_ indexPath: IndexPath) -> Bool
}

extension SectionedListView {
    func indexPathIsInBounds(_ indexPath: IndexPath) -> Bool {
        return indexPath.section >= 0 && indexPath.item >= 0 && indexPath.section < numberOfSections() && indexPath.row < numberOfItems(inSection: indexPath.section)
    }
    func absoluteIndex(with indexPath: IndexPath) -> Int? {
        guard indexPath.isValidforSectionedListView, indexPathIsInBounds(indexPath) else { return nil }
        var index = 0
        if indexPath.section > 0 {
            for i in 0..<indexPath.section {
                index += numberOfItems(inSection: i)
            }
        }
        index += (indexPath.row)
        return index
    }
}
