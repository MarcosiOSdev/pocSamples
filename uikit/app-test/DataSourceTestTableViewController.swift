//
//  DataSourceTestTableViewController.swift
//  app-test
//
//  Created by Marcos Felipe Souza Pinto on 30/03/23.
//

import UIKit

class DataSourceTestTableViewController: UIViewController {
    
    private var storage = MyDataSourceStorage()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        tableView.delegate = self
        return tableView
    }()

    lazy var datasource = UITableViewDiffableDataSource<String, MyModel>(tableView: tableView) { tableView, indexPath, itemIdentifier in
        var cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MyCell")
        }
        cell?.textLabel?.text = itemIdentifier.title
        cell?.detailTextLabel?.text = itemIdentifier.subtitle
        return cell
    }
    
    lazy var myDataSource = MyDataSource(storage: storage, tableView: tableView) { tableView, indexPath, itemIdentifier in
        var cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MyCell")
        }
        cell?.textLabel?.text = itemIdentifier.title
        cell?.detailTextLabel?.text = itemIdentifier.subtitle
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        createDataSource()
    }
    
    private func createDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<String, MyModel>()
        snapshot.appendSections(storage.sections)
        
        for section in storage.sections {
            snapshot.appendItems(storage.valueAtSection(section), toSection: section)
        }
        myDataSource.apply(snapshot)
        myDataSource.defaultRowAnimation = .left
    }
}

extension DataSourceTestTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(storage.modelForIndexPath(indexPath))
        myDataSource.delete(at: indexPath)
    }
}

class MyDataSource: UITableViewDiffableDataSource<String, MyModel> {
    
    private var storage: MyDataSourceStorage
    init(
        storage: MyDataSourceStorage,
        tableView: UITableView,
        cellProvider: @escaping UITableViewDiffableDataSource<String, MyModel>.CellProvider
    ) {
        self.storage = storage
        super.init(tableView: tableView, cellProvider: cellProvider)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName = storage.nameSection(section)
        return "This is section: \(sectionName)"
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            delete(at: indexPath)
        }
    }
    
    func delete(at indexPath: IndexPath) {
        let model = storage.modelForIndexPath(indexPath)
        
        var snapshot = self.snapshot()
        snapshot.deleteItems([model])
        apply(snapshot)
        
        storage.deleteModel(model)
    }
}

class MyDataSourceStorage {
    private var values: [String: [MyModel]] = [
        "Number":
        [MyModel(id: UUID(), title: "One", subtitle: "One mock here"),
        MyModel(id: UUID(), title: "Two", subtitle: "Two mock here"),
        MyModel(id: UUID(), title: "Three", subtitle: "Three mock here"),
        MyModel(id: UUID(), title: "Four", subtitle: "Four mock here")],
        
        "Names":
        [MyModel(id: UUID(), title: "My", subtitle: "Marcos Felipe"),
        MyModel(id: UUID(), title: "Daugther", subtitle: "Laura Gomes"),
        MyModel(id: UUID(), title: "Wife", subtitle: "Taiana")],
    ]
    
    var sections: [String] {
        Array(values.keys)
    }
    
    func valueAtSection(_ section: String) -> [MyModel] {
        return values[section] ?? []
    }
    
    func nameSection(_ section: Int) -> String {
        return Array(values.keys)[section]
    }
 
    func modelForIndexPath(_ indexPath: IndexPath) -> MyModel {
        let keyForSection = Array(values.keys)[indexPath.section]
        let rows = values[keyForSection]
        return rows?[indexPath.row] ?? MyModel(id: UUID(), title: "nil", subtitle: "nil")
    }
    
    func deleteModel(_ model: MyModel) {
        for (key, value) in values {
            var copyValue = value
            copyValue.removeAll { $0 == model }
            values[key] = copyValue
        }
    }
}

struct MyModel: Hashable {
    let id: UUID
    let title: String
    let subtitle: String
}
