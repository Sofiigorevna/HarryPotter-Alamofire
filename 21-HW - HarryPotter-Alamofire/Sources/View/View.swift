//
//  View.swift
//  21-HW - HarryPotter-Alamofire
//
//  Created by 1234 on 08.10.2023.
//

import UIKit

final class MainView: UIView {
    
    // MARK: - Outlets
    
    var data: [Characters] = []
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .brown
        return tableView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarhy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error in Cell")
    }
    
    // MARK: - Setup
        
    private func setupHierarhy() {
        self.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.frame = self.bounds
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}



