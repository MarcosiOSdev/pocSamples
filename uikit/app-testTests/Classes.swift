//
//  Classes.swift
//  app-testTests
//
//  Created by Marcos Felipe Souza Pinto on 16/05/23.
//

import Combine
import UIKit

class ImageLoader {
    
    var images = [URL: UIImage]()
    var cancellables = Set<AnyCancellable>()
    
    let network: ImageNetworking
    
    init(
        _ notificationCenter: NotificationCenter = NotificationCenter.default,
        network: ImageNetworking = ImageNetworkProvider()
    ) {
        self.network = network
        
        let notification = UIApplication.didReceiveMemoryWarningNotification
        notificationCenter.publisher(for: notification)
            .sink(receiveValue: { [weak self] _ in
                self?.images = [URL: UIImage]()
            })
            .store(in: &cancellables)
    }
    
    private func configureMemoryWarning() {
        
    }
    
    func loadImage(at url: URL) -> AnyPublisher<UIImage, Error> {
        if let image = images[url] {
            return Just(image)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        return network.loadURL(url)
            .tryMap({ data in
                guard let image = UIImage(data: data) else {
                    throw ImageLoaderError.invalidData
                }
                return image
            })
            .handleEvents(receiveOutput: { [weak self] image in
                self?.images[url] = image
            })
            .eraseToAnyPublisher()
    }
}

class ImageNetworkProvider: ImageNetworking {
    func loadURL(_ url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError({$0 as Error})
            .map(\.data)
            .eraseToAnyPublisher()
    }
}

enum ImageLoaderError: Error {
    case invalidData
}

protocol ImageNetworking {
    func loadURL(_ url: URL) -> AnyPublisher<Data, Error>
}
