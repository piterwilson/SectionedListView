//
//  AbsoluteIndexProvider.swift
//  tableview-extension
//
//  Created by Juan Carlos Ospina Gonzalez on 21/02/2019.
//  Copyright © 2019 Juan Carlos Ospina Gonzalez. All rights reserved.
//

import Foundation

protocol AbsoluteIndexProvider {
    func absoluteIndex(with indexPath: IndexPath) -> Int?
}
