//
//  ImageCache.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import UIKit
import SwiftUI

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    private let url: URL
    private var cache = ImageCache.shared

    init(url: URL) {
        self.url = url
        cache.countLimit = 50
    }

    private func saveToDisk(_ image: UIImage, forKey key: String) {
        let fileManager = FileManager.default
        guard let data = image.pngData() else { return }
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let filePath = cacheDirectory.appendingPathComponent(key)
        try? data.write(to: filePath)
    }

    
    private func loadFromDisk(forKey key: String) -> UIImage? {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let filePath = cacheDirectory.appendingPathComponent(key)
        guard let data = try? Data(contentsOf: filePath) else { return nil }
        return UIImage(data: data)
    }
    
    func load() {
        let cacheKey = NSString(string: url.absoluteString)

        if let cachedImage = cache.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }

        if let diskImage = loadFromDisk(forKey: url.lastPathComponent) {
            self.image = diskImage
            cache.setObject(diskImage, forKey: cacheKey)
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard
                let self = self,
                let data = data,
                let downloadedImage = UIImage(data: data)
            else {
                return
            }

            DispatchQueue.main.async {
                self.image = downloadedImage
                self.cache.setObject(downloadedImage, forKey: cacheKey)
                self.saveToDisk(downloadedImage, forKey: self.url.lastPathComponent)
            }
        }.resume()
    }
}
