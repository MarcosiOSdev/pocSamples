//
//  Mocks.swift
//  app-testTests
//
//  Created by Marcos Felipe Souza Pinto on 16/05/23.
//

import Combine
import UIKit

class MockImageNetworkProvider: ImageNetworking {
    var wasLoadURLCalled = false
    func loadURL(_ url: URL) -> AnyPublisher<Data, Error> {
        wasLoadURLCalled = true
        let data = UIImage(systemName: "house")!.pngData()!
        return Just(data)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
