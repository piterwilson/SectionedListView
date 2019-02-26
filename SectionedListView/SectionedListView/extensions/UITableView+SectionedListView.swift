//
//  UITableView+SectionedListView.swift
//  tableview-extension
//
//  Created by Juan Carlos Ospina Gonzalez on 21/02/2019.
//  Copyright © 2019 Juan Carlos Ospina Gonzalez. All rights reserved.
//

import Foundation
import UIKit

extension UITableView: SectionedListView {
    func numberOfSections() -> Int {
        return numberOfSections
    }
    func numberOfItems(inSection section: Int) -> Int {
        return numberOfRows(inSection: section)
    }
}
