//
//  IndexPath+SectionedListView.swift
//  tableview-extension
//
//  Created by Juan Carlos Ospina Gonzalez on 21/02/2019.
//  Copyright © 2019 Juan Carlos Ospina Gonzalez. All rights reserved.
//

import Foundation

let INDEXPATH_COUNT_REQUIRED_FOR_SECTIONED_LISTVIEW: Int = 2

extension IndexPath {
    var isValidforSectionedListView: Bool {
        return count == INDEXPATH_COUNT_REQUIRED_FOR_SECTIONED_LISTVIEW
    }
}
