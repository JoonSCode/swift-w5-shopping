//
//  FileManager.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/03.
//

import Foundation

class MyFileManager: FileManager, ImageManaging {
    func getImageFromCache(imageUrl: URL) -> Data? {
        guard let localURL = urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        var filePath = URL(fileURLWithPath: localURL.path)
        filePath.appendPathComponent(imageUrl.lastPathComponent)
        guard fileExists(atPath: filePath.path) else { return nil }
        return try? Data(contentsOf: imageUrl)
    }

    func saveImageAtCahe(imageUrl: URL) {
        guard let localURL = urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        var filePath = URL(fileURLWithPath: localURL.path)
        filePath.appendPathComponent(imageUrl.lastPathComponent)
        do {
            try copyItem(at: imageUrl, to: filePath)
        } catch {
            print("error writing file \(imageUrl)")
        }
    }
}

protocol ImageManaging {
    func getImageFromCache(imageUrl: URL) -> Data?
    func saveImageAtCahe(imageUrl: URL)
}
