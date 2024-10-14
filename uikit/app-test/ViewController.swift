//
//  ViewController.swift
//  app-test
//
//  Created by Marcos Felipe Souza Pinto on 26/10/22.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var browserWebView: WKWebView!
    
    var setupText: SetupText = HelloWorldText()
    
    static var createTab = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = setupText.getText()
        descriptionTextView.attributedText = "Oiii.. \n Eu sou <b> Marcos </b>. <p style='color:red;'>This is a paragraph.</p> ".htmlToAttributedString
        
        
        "Oiii.. \n Eu sou <b> Marcos </b>. <p style='color:red;'>This is a paragraph.</p> ".htmlToAttributedString
        
        browserWebView.loadHTMLString("<html><body><p>Hello!</p></body></html>", baseURL: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if ViewController.createTab {
            let mytab = MyTabBar()
            mytab.modalPresentationStyle = .fullScreen
            present(mytab, animated: false)
            ViewController.createTab.toggle()
        }
    }


}

import Combine
class CustomViewController: UIViewController {
    
    var actionButton = PassthroughSubject<Void, Never>()
    var cancellable: AnyCancellable?
    var cancellable2: AnyCancellable?
    let sut = FCNAssets()
    let sut2 = FCNAssets()
    
    private let color: UIColor
    
    private lazy var addTabbarButton: UIButton = {
        let button = UIButton(configuration: .borderedProminent())
        button.setTitle("Add Tab", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "- $ 300,00"
        return label
    }()
    
    init(color: UIColor) {
        self.color = color
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color
                        
        
        view.addSubview(addTabbarButton)
        view.addSubview(textLabel)
        NSLayoutConstraint.activate([
            addTabbarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addTabbarButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            textLabel.bottomAnchor.constraint(equalTo: addTabbarButton.topAnchor, constant: -8),
            textLabel.leadingAnchor.constraint(equalTo: addTabbarButton.leadingAnchor, constant: 8),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let fullText = "- $ 300,00" //texto completo
        var justNumber: String = ""
        if fullText.hasPrefix("- ") { // verify si hay prefix
            justNumber = String(fullText.dropFirst(2)) // remove 2 por cuenta del prefix.
        }
        
        if let range = fullText.range(of: justNumber) { // toma el range donde empeza $ 300,00 que es lo que quieres strike
            
            // passa range to NSRange
            let nsRange = NSRange(range, in: fullText)
            
            // envia para tu function que crea strike texto(fullText) y range(nsRange)
            let attributedText = NSMutableAttributedString(string: fullText)
            attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                        value: NSUnderlineStyle.single.rawValue,
                                        range: nsRange)
            
            textLabel.attributedText = attributedText
        }        
        
    }
    
    @objc
    func didTapButton() {
        cancellable = sut.getImage(with: "key", duration: 5)
        cancellable?.cancel()
        cancellable2 = sut.getImage(with: "key", duration: 2)
        actionButton.send()
    }
}

class MyTabBar: UITabBarController, UITabBarControllerDelegate {
    
    var cancellables = Set<AnyCancellable>()
    
    override var selectedIndex: Int {
        didSet {
            print("GOT HERE selectedIndex == \(selectedIndex)")
        }
    }
    
    override var selectedViewController: UIViewController? {
        didSet{
            print("GOT HERE selectedViewController == \(type(of:selectedViewController))")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBar.tintColor = .label
        delegate = self
        setupVCs()
    }
    
    
    func setupVCs() {
        
        let tableDataSourceDiff = DataSourceTestTableViewController()
        
        let customVCOne = CustomViewController(color: .systemRed)
        customVCOne.actionButton.sink { _ in
            self.viewControllers?.append(self.createNavController(for: CustomViewController(color: .systemPink), title: "Other", image: UIImage(systemName: "ellipsis.rectangle")))
        }.store(in: &cancellables)
        
        
        let expandableList = ExpandableTableViewController(nibName: nil, bundle: nil)
        
        let stackList = StackCardsViewController()
        
        setViewControllers([
            createNavController(for: stackList, title: "Stack", image: UIImage(systemName: "person")),
            createNavController(for: customVCOne, title: "One", image: UIImage(systemName: "house")),
            createNavController(for: tableDataSourceDiff, title: "Diff", image: nil),
            createNavController(for: expandableList, title: "Expandable", image: UIImage(systemName: "ellipsis.rectangle"))
        ], animated: true)
    }
    
    func createNavController(
        for rootViewController: UIViewController,
        title: String,
        image: UIImage?
    ) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navigationController
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("GOT HERE = shouldSelectVC \(selectedIndex) -- \(tabBarController.selectedIndex)")
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("GOT HERE didSelectVC")
    }
}

protocol SetupText: AnyObject {
    func getText() -> String
}

class AbstractSetupText: SetupText {
    func getText() -> String {
        "Hola soy Abstract"
    }
}

class HelloWorldText: AbstractSetupText {
    override func getText() -> String {
        "Hello World"
    }
}
