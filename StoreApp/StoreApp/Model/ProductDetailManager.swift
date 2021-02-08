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
        NetworkHandler.getData(storeDomain: product.storeDomain, productId: product.productId) { data in
            let decoder = JsonDecoder()
            self.productDetail = decoder.parseDataToDetail(data: data)
            self.productDetail?.title = product.title
            NotificationCenter.default.post(name: .getProductDetailFinished, object: nil)
        }
    }
}

extension Notification.Name {
    static let getProductDetailFinished = Notification.Name("getProductDetailFinished")
}
