//
//  MeliMasViewController.swift
//  app-test
//
//  Created by mfelipesp on 29/11/24.
//

import UIKit

class MeliMasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
    
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let meliMasView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    /// Aca se guarda heigh de MeliMas
    var heightMeliMas: NSLayoutConstraint?
    var sizeMaxMeliMas: CGFloat = 33
    
    override func viewDidLoad() {
        
        view.backgroundColor = .yellow
        
        view.addSubview(tableView)
        view.addSubview(meliMasView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        heightMeliMas = meliMasView.heightAnchor.constraint(equalToConstant: sizeMaxMeliMas)
        heightMeliMas?.isActive = true
        heightMeliMas?.priority = .defaultHigh
        
        
        NSLayoutConstraint.activate([
            
            // Prente MeliMas en Top y no en Bottom
            meliMasView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            meliMasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            meliMasView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Aca la tabla queda en top con meliMas.
            tableView.topAnchor.constraint(equalTo: meliMasView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let absOffSet = abs(scrollView.contentOffset.y)
        if scrollView.contentOffset.y > 10  {
            heightMeliMas?.constant = sizeMaxMeliMas - absOffSet + 10
            UIView.animate(withDuration: 0.1) {
                self.meliMasView.layoutIfNeeded()
            }
        }
    }
}

