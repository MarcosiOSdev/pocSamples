//
//  CustomTabbarViewController.swift
//  app-test
//
//  Created by Marcos Felipe Souza Pinto on 26/01/23.
//

import UIKit

class CustomTabbarViewController: UITabBarController, UITabBarControllerDelegate {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    
    func commonInit() {
        delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("got here")
        return true
    }
}
