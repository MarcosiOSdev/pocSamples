//
//  FCNAssets.swift
//  app-testTests
//
//  Created by Marcos Felipe Souza Pinto on 24/05/23.
//

import Combine
import XCTest
@testable import app_test

final class FCNAssetTests: XCTestCase {
    var cancellable: AnyCancellable?
    var cancellable2: AnyCancellable?
    func testImageLoaderLoadsImageFromNetwork() {
        let sut = FCNAssets()
        let sut2 = FCNAssets()
        cancellable = sut.getImage(with: "key", duration: 3)
        cancellable2 = sut2.getImage(with: "key ", duration: 5)
        
        XCTAssertEqual(cancellable, cancellable2)
    }
}
