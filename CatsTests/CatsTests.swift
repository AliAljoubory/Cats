//
//  CatsTests.swift
//  CatsTests
//
//  Created by Ali Aljoubory on 25/12/2020.
//

import XCTest
@testable import Cats

class CatsTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testValidCellID() {
        let reuseID = CatCell.reuseID
        let validReuseID = "CatCell"
        
        XCTAssertEqual(reuseID, validReuseID)
    }
    
    func testValidPlaceholderImage() {
        let placeholderImage = Images.placeholder
        let validPlaceholderImage = UIImage(systemName: "person.circle")
        
        XCTAssertEqual(placeholderImage, validPlaceholderImage)
    }
}
