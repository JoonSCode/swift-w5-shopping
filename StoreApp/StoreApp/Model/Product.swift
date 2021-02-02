//
//  ProductJSON.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import Foundation
import UIKit

struct Product: Decodable {
    var storeDomain, productName: String
    var productImage: URL
    var productId: Int // UUID 가능?
    var originalPrice: Int
    var groupDiscountUserCount, groupDiscountedPrice: Int?

    var title: String {
        return productName
    }

    var price: String {
        var price = "톡딜가"
        if let discountedPrice = groupDiscountedPrice {
            price += " \(discountedPrice)"
        }
        price += " \(originalPrice)"
        return price
    }

    var participant: String {
        guard let participant = groupDiscountUserCount else { return "" }
        return "현재 참여중 \(participant)"
    }
}
