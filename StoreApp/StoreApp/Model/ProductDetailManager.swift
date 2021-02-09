//
//  ProductDetailManager.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/05.
//

import Foundation

class ProductDetailManager {
    static let instance = ProductDetailManager()
    var productDetail: ProductDetail?
    var previewImages: [URL]? {
        return productDetail?.previewImages
    }

    private init() {}

    public func getProductDetail(product: Product) {
        if getProductDetailFromUserDefault(storeDomain: product.storeDomain, productId: product.productId) {
            NotificationCenter.default.post(name: .getProductDetailFinished, object: nil)
            return
        }
        print("인터넷씀")
        NetworkHandler.getData(storeDomain: product.storeDomain, productId: product.productId) { data in
            let decoder = JsonDecoder()
            self.productDetail = decoder.parseDataToDetail(data: data)
            self.productDetail?.title = product.title
            self.saveProductDetailAtUserDefault(storeDomain: product.storeDomain, productId: product.productId)
            NotificationCenter.default.post(name: .getProductDetailFinished, object: nil)
        }
    }

    private func getProductDetailFromUserDefault(storeDomain: String, productId: Int) -> Bool {
        guard let productDetailData = UserDefaults.standard.object(forKey: "\(storeDomain):\(String(productId))") as? Data else { return false }
        let decoder = JSONDecoder()
        guard let productDetail = try? decoder.decode(ProductDetail.self, from: productDetailData) else { return false }
        self.productDetail = productDetail
        return true
    }

    internal func saveProductDetailAtUserDefault(storeDomain: String, productId: Int) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(productDetail) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "\(storeDomain):\(String(productId))")
        }
    }
}

extension Notification.Name {
    static let getProductDetailFinished = Notification.Name("getProductDetailFinished")
}
