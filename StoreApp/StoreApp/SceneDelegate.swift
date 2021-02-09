//
//  SceneDelegate.swift
//  StoreApp
//
//  Created by 윤준수 on 2021/02/01.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let productManger = ProductManagerImpl.instance

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        if let products = UserDefaults.standard.object(forKey: "products") as? Data {
            let decoder = JSONDecoder()
            if let loadedProducts = try? decoder.decode([ProductType: [Product]].self, from: products) {
                productManger.setAllData(products: loadedProducts)
            }
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(productManger.getAllData()) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "products")
        }
    }


}

