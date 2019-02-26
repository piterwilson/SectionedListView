# The problem
For custom business logic purpouses we are required to obtain the absolute index describing the position of a row in a table view. In the same project, the same requirement applies to a collection view. This index should take into account rows/items in previous sections, therefore querying the `row` or `item` property in an `IndexPath` is not enough.

## Approach

In the initial approaches i created an extension for both `UITableView` and `UICollectionView` that declared a single function that provides an absolute index given an `IndexPath` representing the position in the same `UITableView` or `UICollectionView`.

This works but it's less than ideal as there's a lot of duplication of code. The similarities in `UITableView` and `UICollectionView` should allow for a cleaner solution. 

In the end i created a common `protocol` that `UITableView` and `UICollectionView` can conform to so they can both talk in the same terms (`SectionedListView`), and then used this to create another `protocol` to return the desired absolute index (`AbsoluteIndexProvider`).

## Pitfalls

* It will necessary to validate that the `IndexPath` actually represents a position in the relevant `UITableView` otherwise the functionality is a lie. We will need a way to signal an invalid `IndexPath` to the user of the API
* Care should be taken to validate the `IndexPath` without causing a crash. Event though the properties `section` and `item` of an `IndexPath` are marked as non-optional, in reality an irrecoverable crash will occur when the instance doesn't actually provide them.

## Solution

Created a protocol to encapsulate the idea of having a single integer describing the position of a cell

#### AbsoluteIndexProvider.swift
```
import Foundation

protocol AbsoluteIndexProvider {
    func absoluteIndex(with indexPath: IndexPath) -> Int?
}
```

Created a protocol to encapsulate the common functionality in `UITableView` and `UICollectionView`, an extended that with the previous `AbsoluteIndexProvider` protocol

#### SectionedListView.swift 
````
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
```

Created a couple more extensions to make `UITableView` and `UICollectionView` comply with `SectionedListView`

#### UICollectionView+SectionedListView.swift 
```
import Foundation
import UIKit

extension UICollectionView: SectionedListView {
    func numberOfSections() -> Int {
        return numberOfSections
    }
}
```

#### UITableView+SectionedListView.swift 
```
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
```

At the end i also had to create this extension, so that we can validate that the `IndexPath` provided to `absoluteIndex(with indexPath: IndexPath)` is actually valid. The API in `IndexPath` leads us to believe that is properties are not optional, but it's possible to create a `IndexPath` without these properties, If we query `section` on such an `IndexPath` we will get a crash that we can't even catch in swift.

```
import Foundation

let INDEXPATH_COUNT_REQUIRED_FOR_SECTIONED_LISTVIEW: Int = 2

extension IndexPath {
    var isValidforSectionedListView: Bool {
        return count == INDEXPATH_COUNT_REQUIRED_FOR_SECTIONED_LISTVIEW
    }
}
```
