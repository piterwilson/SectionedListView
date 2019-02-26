# The problem
For custom business logic purpouses we are required to obtain the absolute index describing the position of a row in a table view. In the same project, the same requirement applies to a collection view. This index should take into account rows/items in previous sections, therefore querying the `row` or `item` property in an `IndexPath` is not enough.

## Approach

In the initial approaches i created an extension to `UITableView` and to `UICollectionView` that declared a single function that provides an absolute index given an `IndexPath` representing the position in the same `UITableView` or `UICollectionView`.

This works but it's less than ideal as there's a lot of duplication of code. THe similarities in `UITableView` and `UICollectionView` should allow for a cleaner solution. 

In the end i created a common `protocol` that `UITableView` and `UICollectionView` can conform to so they can both talk in the same terms (`SectionedListView`), and then used this to create another `protocol` to return the desired absolute index (`AbsoluteIndexProvider`).

## Pitfalls

* It will necessary to validate that the `IndexPath` actually represents a position in the relevant `UITableView` otherwise the functionality is a lie. We will need a way to signal an invalid `IndexPath` to the user of the API
* Care should be taken to validate the `IndexPath` without causing a crash. Event though the properties `section` and `item` of an `IndexPath` are marked as non-optional, in reality an irrecoverable crash will occur when the instance doesn't actually provide them.