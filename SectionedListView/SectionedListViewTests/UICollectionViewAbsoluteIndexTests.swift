
import XCTest
import UIKit
@testable import SectionedListView

class UICollectionViewAbsoluteIndexTests: XCTestCase, UICollectionViewDataSource {
    
    let dummieContent = [
        ["1", "2", "3"],
        ["1"],
        ["1", "2"]
    ]
    
    var sut: UICollectionView!
    
    override func setUp() {
        sut = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        sut.dataSource = self
        sut.reloadData()
    }
    
    func testValidIndices() {
        var indexPath = IndexPath(row: 0, section: 0)
        var index = sut.absoluteIndex(with: indexPath)
        XCTAssertEqual(index, 0, "expected 0 got \(String(describing: index))")
        
        indexPath = IndexPath(row: 1, section: 0)
        index = sut.absoluteIndex(with: indexPath)
        XCTAssertEqual(index, 1, "expected 1 got \(String(describing: index))")
        
        indexPath = IndexPath(row: 2, section: 0)
        index = sut.absoluteIndex(with: indexPath)
        XCTAssertEqual(index, 2, "expected 2 got \(String(describing: index))")
        
        indexPath = IndexPath(row: 0, section: 1)
        index = sut.absoluteIndex(with: indexPath)
        XCTAssertEqual(index, 3, "expected 3 got \(String(describing: index))")
        
        indexPath = IndexPath(row: 0, section: 2)
        index = sut.absoluteIndex(with: indexPath)
        XCTAssertEqual(index, 4, "expected 4 got \(String(describing: index))")
        
        indexPath = IndexPath(row: 1, section: 2)
        index = sut.absoluteIndex(with: indexPath)
        XCTAssertEqual(index, 5, "expected 5 got \(String(describing: index))")
    }
    
    func testInvalidIndices() {
        
        var indexPath = IndexPath(row: 0, section: 3)
        var index = sut.absoluteIndex(with: indexPath)
        XCTAssertNil(index, "expected nil got \(String(describing: index))")
        
        indexPath = IndexPath(row: 0, section: 4)
        index = sut.absoluteIndex(with: indexPath)
        XCTAssertNil(index, "expected nil got \(String(describing: index))")
        
        indexPath = IndexPath(row: 2, section: 3)
        index = sut.absoluteIndex(with: indexPath)
        XCTAssertNil(index, "expected nil got \(String(describing: index))")
        
        indexPath = IndexPath(row: 1000, section: 0)
        index = sut.absoluteIndex(with: indexPath)
        XCTAssertNil(index, "expected nil got \(String(describing: index))")
        
        indexPath = IndexPath(row: 1000, section: 1000)
        index = sut.absoluteIndex(with: indexPath)
        XCTAssertNil(index, "expected nil got \(String(describing: index))")
        
        indexPath = IndexPath(item: 5, section: 0)
        index = sut.absoluteIndex(with: indexPath)
        XCTAssertNil(index, "expected nil got \(String(describing: index))")
    }
    
    func testEdgeCaseIndices() {
        
        var indexPath = IndexPath(index: 0)
        var index = sut.absoluteIndex(with: indexPath)
        XCTAssertNil(index, "expected nil got \(String(describing: index))")
        
        indexPath = IndexPath(index: 1)
        index = sut.absoluteIndex(with: indexPath)
        XCTAssertNil(index, "expected nil got \(String(describing: index))")
        
        indexPath = IndexPath(row: -1, section: -1)
        index = sut.absoluteIndex(with: indexPath)
        XCTAssertNil(index, "expected nil got \(String(describing: index))")
        
        indexPath = IndexPath(item: 0, section: 0)
        index = sut.absoluteIndex(with: indexPath)
        XCTAssertEqual(index, 0, "expected 0 got \(String(describing: index))")
        
        indexPath = IndexPath(indexes: [0, 0])
        index = sut.absoluteIndex(with: indexPath)
        XCTAssertEqual(index, 0, "expected 0 got \(String(describing: index))")
        
        indexPath = IndexPath(indexes: [1, 0])
        index = sut.absoluteIndex(with: indexPath)
        XCTAssertEqual(index, 3, "expected 3 got \(String(describing: index))")
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummieContent[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dummieContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    }
}
