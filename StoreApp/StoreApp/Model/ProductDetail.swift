//
//  ProductDetail.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/04.
//

import Foundation

struct ProductDetailJson: Decodable {
    var result: Bool
    var data: ProductDetail
}

struct ProductDetail: Decodable {
    var title: String?
    var previewImages: [URL]
    var description: String
    var review: Review
    var talkDeal: TalkDeal?
    var store: Store
    var delivery: Delivery
    var price: Price
    var notices: [Notice]

    struct Review: Decodable {
        var totalProductStarRating: Double
        var reviewCount: Int
    }

    struct TalkDeal: Decodable {
        var status: Status
        var discountPrice: Int
        enum Status: String, Decodable {
            case ON_SALE
        }
    }

    struct Store: Decodable {
        var name: String
    }

    struct Price: Decodable {
        var standardPrice, discountedPrice, minDiscountedPrice, maxDiscountedPrice: Int
        var discountRate: String
    }

    struct Delivery: Decodable {
        var deliveryFeeType: DeliveryFeeType
        var deliveryFee: Int

        enum DeliveryFeeType: String, Decodable {
            case FREE
            case PAID
        }
    }

    struct Notice: Decodable {
        var title: String
        var createdAt: String
    }
}
