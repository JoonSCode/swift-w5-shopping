//
//  NetworkHandler.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import Foundation

class NetworkHandler {

    private static let baseURL: String = "http://public.codesquad.kr/jk/kakao-2021"
    private static let productURLs: [String] = ["/best.json","/mask.json","/grocery.json","/flyingpan.json"]
    
    enum ProductType: Int {
        case Best = 0
        case Mask = 1
        case Grocery = 2
        case Flyingpan = 3
    }

    class func getData(productType: ProductType) {
        // 세션 생성, 환경설정
        let defaultSession = URLSession(configuration: .default)

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
            let jsonArray = decoder.parseData(data: data)
            // 원하는 작업
        }
        dataTask.resume()
    }
}
