//
//  ViewController.swift
//  21-HW - HarryPotter-Alamofire
//
//  Created by 1234 on 08.10.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    private var mainView = MainView()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .webSearch
        textField.placeholder = "Search..."
        textField.backgroundColor = .systemBrown
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var barButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 23, weight: UIImage.SymbolWeight.thin), forImageIn: .normal)
        button.imageView?.tintColor = .black
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        return button
    }()
    
    private lazy var textFieldStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textField, barButton])
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    var data: [Characters] = []
    
    var dataHandler = [Characters]()
    
    //  MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewConfiguration()
        dataHandler = data
        title = "Hogwarts students"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.titleView = textFieldStack
    }
    
    // MARK: - Setup
   
    
    private func setupView() {
        APIFetchHandler.sharedInstance.fetchAPIData(queryItemValue: nil){ apiData in
            self.data = apiData
            
            DispatchQueue.main.async{
                self.mainView.tableView.reloadData()
            }
        }
    }
    private func viewConfiguration() {
        mainView.tableView.register(CastomTableViewCell.self, forCellReuseIdentifier: "cell")
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        NSLayoutConstraint.activate([
            textFieldStack.widthAnchor.constraint(equalToConstant: 320),
            textFieldStack.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    // MARK: - Actions
    
    
    
    @objc func buttonAction() {
        
        
        if let searchText = self.textField.text {
            dataHandler = data.filter{$0.name!.localizedCaseInsensitiveContains(searchText) || $0.actor!.localizedCaseInsensitiveContains(searchText)
            }
            self.mainView.tableView.reloadData()

        }
        
        
        
        
        
        
        
//        APIFetchHandler.sharedInstance.fetchAPIData{ apiData in
//            self.data = apiData

//            var searchText = self.textField.text
//            self.dataHandler.removeAll()
//
//            if searchText == "" || searchText == " " {
//                print("empty search")
//                self.dataHandler = data
//                self.mainView.tableView.reloadData()
//                return
//            }
//
//            for item in data {
//                let text = searchText?.lowercased()
//                let isArrayContain = item.name!.lowercased().range(of: text!)
//
//                if isArrayContain != nil {
//                    print("success")
//                    self.dataHandler.append(item)
//                }
//            }
//            print(self.dataHandler)
    //    }

    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CastomTableViewCell
        cell?.character = data[indexPath.row]
        cell?.contentView.backgroundColor = .systemBrown
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        present(viewController, animated: true)
        viewController.character = data[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

