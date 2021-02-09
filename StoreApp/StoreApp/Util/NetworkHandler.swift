//
//  NetworkHandler.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import Foundation
import UIKit

class NetworkHandler {
    private static let fileManager: ImageManaging = MyFileManager()

    class func getData(productType: ProductType, completionHandler: @escaping ([Product]) -> ()) {
        // 세션 생성, 환경설정
        let defaultSession = URLSession(configuration: .default)
        let baseURL: String = "http://public.codesquad.kr/jk/kakao-2021"
        let productURLs: [String] = ["/best.json", "/mask.json", "/grocery.json", "/fryingpan.json"]
        
        guard let url = URL(string: "\(baseURL)\(productURLs[productType.rawValue])") else {
            print("URL is nil")
            return
        }

        // Request
        let request = URLRequest(url: url)

        // dataTask
        let dataTask = defaultSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            // getting Data Error
            guard error == nil else {
                print("Error occur: \(String(describing: error))")
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            let decoder = JsonDecoder()
            guard let products = decoder.parseDataToProducts(data: data) else { return }
            completionHandler(products)
        }
        dataTask.resume()
    }

    class func getData(storeDomain: String, productId: Int, completionHandler: @escaping (Data) -> ()) {
        let defaultSession = URLSession(configuration: .default)
        let baseURL: String = "https://store.kakao.com/a"
        guard let url = URL(string: "\(baseURL)/\(storeDomain)/product/\(String(productId))/detail") else {
            print("URL is nil")
            return
        }
        // Request
        let request = URLRequest(url: url)

        // dataTask
        let dataTask = defaultSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            // getting Data Error
            guard error == nil else {
                print("Error occur: \(String(describing: error))")
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
        
           completionHandler(data)
        }
        dataTask.resume()
    }
    
    class func getImage(url: URL, completionHandler: @escaping (Data) -> Void) {
        if let imageData = fileManager.getImageFromCache(imageUrl: url) {
            completionHandler(imageData)
        }
        let defaultSession = URLSession(configuration: .default)
        let downloadTask = defaultSession.downloadTask(with: url) { tempLocalURL, response, error in
            guard error == nil else {
                print("Error occur: \(String(describing: error))")
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }

            guard let tempLocalURL = tempLocalURL else { return }
            fileManager.saveImageAtCahe(imageUrl: tempLocalURL)
            if let imageData = fileManager.getImageFromCache(imageUrl: tempLocalURL) {
                completionHandler(imageData)
            }
        }
        downloadTask.resume()
    }
}
