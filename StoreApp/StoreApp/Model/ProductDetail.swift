//
//  ProductDetail.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/04.
//

import Foundation

struct ProductDetailJson: Codable {
    var result: Bool
    var data: ProductDetail
}

struct ProductDetail: Codable {
    var title: String?
    var previewImages: [URL]
    var description: String
    var review: Review
    var talkDeal: TalkDeal?
    var store: Store
    var delivery: Delivery
    var price: Price
    var notices: [Notice]

    struct Review: Codable {
        var totalProductStarRating: Double
        var reviewCount: Int
    }

    struct TalkDeal: Codable {
        var status: Status
        var discountPrice: Int
        enum Status: String, Codable {
            case ON_SALE
            case AFTER_SALE
        }
    }

    struct Store: Codable {
        var name: String
    }

    struct Price: Codable {
        var standardPrice, discountedPrice, minDiscountedPrice, maxDiscountedPrice: Int
        var discountRate: String
    }

    struct Delivery: Codable {
        var deliveryFeeType: DeliveryFeeType
        var deliveryFee: Int

        enum DeliveryFeeType: String, Codable {
            case FREE
            case PAID
        }
    }

    struct Notice: Codable {
        var title: String
        var createdAt: String
    }
}
