//
//  HorizontalDirectionTests.swift
//  LayoutTests
//
//  Created by Garric Nahapetian on 4/11/23.
//

@testable import Layout
import Nimble
import XCTest

final class HorizontalDirectionTests: XCTestCase {

    func testLeadingToTrailingAttributes() {
        expect(HorizontalDirection.leadingToTrailing.attributes) == (.leading, .trailing)
    }

    func testLeftToRightAttributes() {
        expect(HorizontalDirection.leftToRight.attributes) == (.left, .right)
    }
}
