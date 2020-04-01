//
//  ServiceTests.swift
//  Rent95Tests
//
//  Created by Vadym on 01.04.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import XCTest
@testable import Rent95

class AppNavigationTests: XCTestCase {
    
    var testNavigation: AppNavigation!
    var testViewController: UIViewController!
    var testURL: URL!
    var testString: String!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        testString = "Baz Bar"
        testURL = URL(string: testString)!
        
        testNavigation = AppNavigation(appURL: testURL)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        testNavigation.openApp(from: testViewController)
        
    }
}
