//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/04.
//

import Toaster
import UIKit
import WebKit

class DetailViewController: UIViewController {
    @IBOutlet var detailMainView: DetailMainView!
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var imageScrollView: UIScrollView!
    var imageViews: [UIImageView] = []
    @IBOutlet var webView: WKWebView!
    var productDetailManager: ProductDetailManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setViewData(_:)), name: .getProductDetailFinished, object: nil)
        detailMainView.initView()
    }

    @objc func setViewData(_: Notification) {
        DispatchQueue.main.async {
            self.setImageAtImageScroll()
        }
        DispatchQueue.main.async {
            self.loadDescription()
        }
        guard let productDetail = productDetailManager?.productDetail else { return }
        DispatchQueue.main.async {
            self.detailMainView.setViewData(productDetail: productDetail)
        }
    }

    func setImageAtImageScroll() {
        guard let imageUrls = productDetailManager?.previewImages else { return }
        for index in imageUrls.indices {
            let imageView = UIImageView()
            imageViews.append(imageView)
            imageScrollView.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            imageView.heightAnchor.constraint(equalTo: imageScrollView.frameLayoutGuide.heightAnchor).isActive = true
            imageView.topAnchor.constraint(equalTo: imageScrollView.contentLayoutGuide.topAnchor).isActive = true
            imageView.leadingAnchor.constraint(equalTo: index == 0 ? imageScrollView.contentLayoutGuide.leadingAnchor : imageViews[index - 1].trailingAnchor).isActive = true
            imageView.setImageByUrl(url: imageUrls[index])
        }
        imageViews[0].leadingAnchor.constraint(equalTo: imageScrollView.contentLayoutGuide.leadingAnchor).isActive = true
        imageScrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(imageViews.count), height: view.bounds.width * 0.75)
    }

    func loadDescription() {
        let meta_java: String = "<meta name=\"viewport\" content=\"width=device-width, shrink-to-fit=YES\">"

        guard let descriptionHtml = productDetailManager?.productDetail?.description else { return }
        webView.loadHTMLString(meta_java + descriptionHtml, baseURL: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        webView = nil
    }
}

extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish _: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.webView.heightAnchor.constraint(equalToConstant: webView.scrollView.contentSize.height).isActive = true
        }
    }
}
