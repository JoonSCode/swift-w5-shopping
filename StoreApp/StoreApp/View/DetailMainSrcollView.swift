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
        var reviewText = ""
        let numOfStar = Int(productDetail.review.totalProductStarRating)
        for _  in 0..<numOfStar{
            reviewText += "★"
        }
        reviewText += " 리뷰\(productDetail.review.reviewCount)건"
        starRate.text = reviewText
        
        purchaseOriginal.setTitle("바로구매 \(productDetail.price.standardPrice)원", for: .normal)
        
        if productDetail.talkDeal?.status == .ON_SALE {
            purchaseDiscount.superview?.isHidden = false
            purchaseDiscount.setTitle("톡딜가 \(productDetail.price.standardPrice - (productDetail.talkDeal?.discountPrice ?? 0))원",for: .normal)
        }
        
        productTitle.text = productDetail.title
        
        if productDetail.delivery.deliveryFeeType == .FREE {
            deliveryFee.text = "배송비 무료"
        }else{
            deliveryFee.text = "배송비 \(productDetail.delivery.deliveryFee)원"
        }
        
        for notice in productDetail.notices {
            print("1111111")
            noticeTitle.text = notice.title
            noticeDate.text = notice.createdAt
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
