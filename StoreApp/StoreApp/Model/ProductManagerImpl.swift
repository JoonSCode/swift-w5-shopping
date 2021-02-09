//
//  ProductManager.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/02.
//

import Foundation

protocol ProductManager {
    func requestAllData()
    func getSectionTitle(at: Int) -> String
    func setProducts(productType: ProductType, products: [Product])
    func getProduct(productType: ProductType, at: Int) -> Product?
    func getCount(productType: ProductType) -> Int
    func getAllData() -> [ProductType: [Product]]
    func setAllData(products: [ProductType: [Product]])
}

class ProductManagerImpl: ProductManager {
    static let instance = ProductManagerImpl()
    let sectionTitle = ["베스트", "마스크", "잡화", "프라이팬"]
    private var products: [ProductType: [Product]] = [:]

    private init() {
        if products.count != 0 { return }
        requestAllData()
    }

    func requestAllData() {
        for type in ProductType.allCases {
            NetworkHandler.getData(productType: type) {
                products in
                DispatchQueue.main.async {
                    self.products[type] = products
                    NotificationCenter.default.post(name: NSNotification.Name("reloadSection"), object: nil, userInfo: ["at": type.rawValue])
                }
            }
        }
    }

    func getSectionTitle(at: Int) -> String {
        return sectionTitle[at]
    }

    func setProducts(productType: ProductType, products: [Product]) {
        print(self.products)
        self.products[productType] = products
    }

    func getProduct(productType: ProductType, at: Int) -> Product? {
        guard let product = products[productType]?[at] else { return nil }
        return product
    }

    func getCount(productType: ProductType) -> Int {
        return products[productType]?.count ?? 0
    }
    
    func getAllData() -> [ProductType : [Product]] {
        return products
    }
    
    func setAllData(products: [ProductType : [Product]]) {
        self.products = products
    }
}

enum ProductType: Int, CaseIterable, Codable {
    case Best = 0
    case Mask
    case Grocery
    case Flyingpan
}
