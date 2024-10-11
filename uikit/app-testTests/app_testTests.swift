//
//  app_testTests.swift
//  app-testTests
//
//  Created by Marcos Felipe Souza Pinto on 16/05/23.
//

import XCTest
import Combine

final class app_testTests: XCTestCase {

    func testImageLoaderLoadsImageFromNetwork() {
        // setup
        let mockNetwork = MockImageNetworkProvider()
        let notificationCenter = NotificationCenter()
        let imageLoader = ImageLoader(notificationCenter, network: mockNetwork)
        let url = URL(string: "https://fake.url/house")!
        // expectations
        let result = awaitCompletion(for: imageLoader.loadImage(at: url))
        XCTAssertNoThrow(try result.get())
        XCTAssertEqual(mockNetwork.wasLoadURLCalled, true)
        XCTAssertNotNil(imageLoader.images[url])
    }
    
    func testViewModelWithPublished() {
        let viewModel = ViewModel()
        let changed = awaitCompletion(for: viewModel.$name)
        viewModel.changeName(with: "new value")
        XCTAssertNoThrow(try changed.get())
        XCTAssertEqual(viewModel.name, "new value")
    }
}

class ViewModel: ObservableObject {
    @Published var name: String = ""
    func changeName(with name: String) {
        self.name = name
    }
}

extension XCTestCase {
    func awaitCompletion<P: Publisher>(for publisher: P) -> Result<[P.Output], P.Failure> {
        let finishedExpectation = expectation(description: "completion expectation")
        var output = [P.Output]()
        var result: Result<[P.Output], P.Failure>!
        _ = publisher.sink(receiveCompletion: { completion in
            if case .failure(let error) = completion {
                result = .failure(error)
            } else {
                result = .success(output)
            }
            finishedExpectation.fulfill()
        }, receiveValue: { value in
            output.append(value)
        })
        waitForExpectations(timeout: 1.0, handler: nil)
        return result
    }
}
