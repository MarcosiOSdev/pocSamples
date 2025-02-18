//
//  PresentsViewController.swift
//  app-test
//
//  Created by mfelipesp on 13/01/25.
//

import UIKit

class PresentsViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let viewController = PresentAViewController()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        present(PresentBViewController(), animated: true)
    }
    
    
}

class PresentAViewController: UIViewController {
    
    let centerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerButton.setTitle("Dismiss", for: .normal)
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerButton)
        centerButton.addTarget(self, action: #selector(didTaDismiss), for: .touchUpInside)
        NSLayoutConstraint.activate([
            
            centerButton.heightAnchor.constraint(equalToConstant: 100),
            centerButton.widthAnchor.constraint(equalToConstant: 100),
            
            centerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.backgroundColor = .blue
    }
    
    @objc
    func didTaDismiss() {
        dismiss(animated: true)
    }
}


class PresentBViewController: UIViewController {
    
    let dismissButton = UIButton()
    let goButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dismissButton)
        dismissButton.addTarget(self, action: #selector(didTaDismiss), for: .touchUpInside)
        NSLayoutConstraint.activate([
            
            dismissButton.heightAnchor.constraint(equalToConstant: 100),
            dismissButton.widthAnchor.constraint(equalToConstant: 100),
            
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.backgroundColor = .systemPink
        
        view.addSubview(goButton)
        goButton.setTitle("GO", for: .normal)
        goButton.translatesAutoresizingMaskIntoConstraints = false
        goButton.addTarget(self, action: #selector(didTaGo), for: .touchUpInside)
        NSLayoutConstraint.activate([
            goButton.heightAnchor.constraint(equalToConstant: 100),
            goButton.widthAnchor.constraint(equalToConstant: 100),
            goButton.topAnchor.constraint(equalTo: dismissButton.bottomAnchor),
            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goButton.leadingAnchor.constraint(equalTo: dismissButton.leadingAnchor)
        ])
    }
    
    @objc
    func didTaDismiss() {
        dismiss(animated: true)
    }
    
    @objc
    func didTaGo() {
        present(PresentAViewController(), animated: true)
    }
}

