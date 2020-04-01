//
//  AppScheme.swift
//  Rent95Tests
//
//  Created by Vadym on 01.04.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import XCTest
@testable import Rent95

class AppSchemeTests: XCTestCase {

    func testEnum() {
        XCTAssertNotNil(AppScheme.App.self)
        XCTAssertEqual(AppScheme.App.phone.rawValue, "tel")
        XCTAssertEqual(AppScheme.App.mail.rawValue, "mailto")
        XCTAssertEqual(AppScheme.App.telegram.rawValue, "tg")
        XCTAssertEqual(AppScheme.App.viber.rawValue, "viber")
        XCTAssertEqual(AppScheme.App.whatsapp.rawValue, "whatsapp")
    }
}
