//
//  JsonDecoder.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import Foundation

class JsonDecoder {
    func parseDataToProducts(data: Data) -> [Product]? {
        let decoder = JSONDecoder()
        var decodeData: [Product]?
//        print(String(decoding: data, as: UTF8.self))
        do {
            decodeData = try decoder.decode([Product].self, from: data)
        }catch {
            print(error.localizedDescription)
        }
        return decodeData
    }
    
    func parseDataToDetail(data: Data) -> ProductDetail? {
        let decoder = JSONDecoder()
        var decodeData: ProductDetailJson?
//        print(String(decoding: data, as: UTF8.self))
        do {
            decodeData = try decoder.decode(ProductDetailJson.self, from: data)
        }catch {
            print(error.localizedDescription)
        }
        return decodeData?.data
    }
}
