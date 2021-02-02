//
//  ViewController.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet var shoppingCollectionView: UICollectionView!
    var productCollectionView = ProductCollcetionView()
    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionView.calculateSize(width: nil)
        shoppingCollectionView.delegate = productCollectionView
        shoppingCollectionView.dataSource = productCollectionView

        NetworkHandler.getData(productType: .Best)
    }
}
