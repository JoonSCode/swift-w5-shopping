//
//  DetailMainSrcollView.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/05.
//

import UIKit
import WebKit

class DetailMainView: UIView {
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var starRate: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var purchaseOriginal: UIButton!
    @IBOutlet weak var purchaseDiscount: UIButton!
    @IBOutlet weak var shopTitle: UILabel!
    @IBOutlet weak var numberOfParticipant: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    @IBOutlet weak var noticeTitle: UILabel!
    @IBOutlet weak var noticeDate: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    func initView() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
    }
    
    func setViewData(productDetail: ProductDetail) {
        setReviewCount(review: productDetail.review)
        setPrice(productDetail: productDetail)
        shopTitle.text = productDetail.store.name
        productTitle.text = productDetail.title
        setDeliveryFee(delivery: productDetail.delivery)
        
        if productDetail.notices.count == 0 {
            noticeTitle.superview?.isHidden = true
        }
        
        for notice in productDetail.notices {
            noticeTitle.text = notice.title
            noticeDate.text = notice.createdAt
        }
    }
    func setReviewCount(review: ProductDetail.Review) {
        var reviewText = ""
        let numOfStar = Int(review.totalProductStarRating)
        for _  in 0..<numOfStar{
            reviewText += "★"
        }
        reviewText += " 리뷰\(review.reviewCount)건"
        starRate.text = reviewText
    }
    
    func setPrice(productDetail: ProductDetail){
        purchaseOriginal.setTitle("바로구매 \(Converter.numberToStringWithComma(number: productDetail.price.standardPrice) ?? "")원", for: .normal)
        purchaseOriginal.layer.cornerRadius = 10
        purchaseOriginal.bounds = purchaseOriginal.titleLabel?.frame ?? purchaseOriginal.bounds
        if productDetail.talkDeal?.status == .ON_SALE {
            purchaseDiscount.isHidden = false
            let dicountedPrice = productDetail.price.standardPrice - (productDetail.talkDeal?.discountPrice ?? 0)
            purchaseDiscount.setTitle("톡딜가 \(Converter.numberToStringWithComma(number: dicountedPrice) ?? "")원",for: .normal)
            purchaseDiscount.layer.cornerRadius = 10
        }
    }
    
    func setDeliveryFee(delivery: ProductDetail.Delivery){
        if delivery.deliveryFeeType == .FREE {
            deliveryFee.text = "배송비 무료"
        }else{
            deliveryFee.text = "배송비 \(delivery.deliveryFee)원"
        }
    }
}
extension DetailMainView: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish _: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.webView.heightAnchor.constraint(equalToConstant: webView.scrollView.contentSize.height).isActive = true
        }
    }
}
