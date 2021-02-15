//
//  ViewController.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import Toaster
import UIKit

class MainViewController: UIViewController {
    @IBOutlet var shoppingCollectionView: UICollectionView!
    private let productManager = ProductManagerImpl.instance
    lazy var productCollectionViewUseCase = ProductCollcetionViewUsecase(productManager: productManager)
    private let productDetailManager = ProductDetailManager.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionViewUseCase.calculateSize(width: nil)
        productCollectionViewUseCase.productManager = productManager
        shoppingCollectionView.delegate = productCollectionViewUseCase
        shoppingCollectionView.dataSource = productCollectionViewUseCase
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSection(_:)), name: NSNotification.Name("reloadSection"), object: nil)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        productCollectionViewUseCase.calculateSize(width: size.width)
        shoppingCollectionView.reloadData()
    }

    @objc func reloadSection(_ noticiation: Notification) {
        guard let index = noticiation.userInfo?["at"] as? Int else { return }
        DispatchQueue.main.async {
            self.shoppingCollectionView.reloadSections(IndexSet(integer: index))
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: shoppingCollectionView) else { return }
        guard let indexPath = shoppingCollectionView.indexPathForItem(at: touchPoint) else { return }
        guard let productType = ProductType(rawValue: indexPath.section) else { return }
        guard let product = productManager.getProduct(productType: productType, at: indexPath.item) else { return }
        Toast(text: "상품명:\(product.title) \n가격:\(product.originalPrice)").start()

        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        navigationController?.pushViewController(detailViewController, animated: true)
        detailViewController.productDetailManager = productDetailManager
        detailViewController.product = product
    }
}
