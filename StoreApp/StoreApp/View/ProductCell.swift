//
//  ProductCell.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var participant: UILabel!
    @IBOutlet var originalPrice: UILabel!
    @IBOutlet var discountedPrice: UILabel!
    func setCell(product: Product) {
        title.text = product.title
        price.text = "톡딜가"
        discountedPrice.text = "\(Converter.numberToStringWithComma(number: product.groupDiscountedPrice ?? 0) ?? "")원"
        originalPrice.text = "\(Converter.numberToStringWithComma(number: product.originalPrice) ?? "")원"
        participant.text = product.participant
        image.setImageByUrl(url: product.productImage)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
}
