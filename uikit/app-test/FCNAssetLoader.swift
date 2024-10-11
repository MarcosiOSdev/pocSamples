//
//  FCNAssetLoader.swift
//  app-test
//
//  Created by Marcos Felipe Souza Pinto on 24/05/23.
//

import UIKit
import Combine

enum ImageProviderError: Error {
    case notFound
}

class ImageProvider {
    
    private var task: Task<UIImage, Error>?
    
    func getImage(url: String) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fbr.ign.com%2Fdragon-ball%2F3783%2Fnews%2Fdia-do-goku-e-oficializado-no-japao&psig=AOvVaw0nIvuxUYaPAbX5lafgoCyy&ust=1685042079030000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCMiTh4fVjv8CFQAAAAAdAAAAABAD")!)
        
        if let image = UIImage(data: data) {
            return image
        } else {
            throw ImageProviderError.notFound
        }
    }
    
    func cancel() {
        task?.cancel()
    }
}


class FCNAssetsStorage {
    static var shared = FCNAssetsStorage()
    private init() {}
    var cancellables = [String: AnyPublisher<UIImage, ImageProviderError>]()
    var provider = ImageProvider()
}

class FCNAssets {
    
    private var storages = FCNAssetsStorage.shared
    
    func getImage(
        with key: String,
        duration: Int? = nil,
        onCompleted: (() -> Void)? = nil
    ) -> AnyCancellable {
        if let image = UIImage(named: key, in: .main, with: .none) {
            return Just(image).sink { _ in }
        }
        
        let future = verifyImage(with: key, duration: duration)
        
        return future.sink { completion in
            switch completion {
            case .failure:
                print("with failure")
                onCompleted?()
            case .finished:
                print("finalizou")
                onCompleted?()
            }
        } receiveValue: { image in
            print("chegou imagem")
            onCompleted?()
        }
    }
    
    private func verifyImage(
        with key: String,
        duration: Int?
    ) -> AnyPublisher<UIImage, ImageProviderError> {
        if let future = storages.cancellables[key] {
            return future
        }
        
        let future = Future<UIImage, ImageProviderError> { promise in
            Task {
                do {
                    let nano = 1_000_000_000
                    let nanoseconds = UInt64(nano * (duration ?? 0))
                    try await Task.sleep(nanoseconds: nanoseconds)
                    let image = try await self.storages.provider.getImage(url: key)
                    promise(.success(image))
                } catch {
                    promise(.failure(.notFound))
                }
            }
        }.eraseToAnyPublisher()
        
        
        storages.cancellables[key] = future
        return future
    }
}
