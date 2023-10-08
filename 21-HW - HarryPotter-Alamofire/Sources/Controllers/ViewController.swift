//
//  ViewController.swift
//  21-HW - HarryPotter-Alamofire
//
//  Created by 1234 on 08.10.2023.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    
    private var mainView = MainView()
    
    var data: [Characters] = []

    //  MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewConfiguration()
        title = "Hogwarts students"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Setup
    
    private func setupView() {
        APIFetchHandler.sharedInstance.fetchAPIData{ apiData in
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
        mainView.tableView.frame = view.bounds
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

