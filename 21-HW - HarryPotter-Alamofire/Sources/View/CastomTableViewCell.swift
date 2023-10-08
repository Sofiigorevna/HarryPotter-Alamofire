//
//  CastomTableViewCell.swift
//  21-HW - HarryPotter-Alamofire
//
//  Created by 1234 on 08.10.2023.
//

import UIKit

class CastomTableViewCell: UITableViewCell {

    let globalQueue =  DispatchQueue.global(qos: .utility)
    
    var character: Characters? {
        didSet {
            actor.text = character?.actor
            name.text = character?.name

            if  let imagePath = self.character?.image,
                let imageURL = URL(string: imagePath){

                globalQueue.async {
                    if let imageData = try? Data(contentsOf: imageURL){
                        DispatchQueue.main.async{
                            self.imagePhoto.image = UIImage(data: imageData )
                        }
                    }
                }
            } else {
                self.imagePhoto.image = UIImage(systemName: "person.fill")
                return
            }
        }
    }
    
    // MARK: - Outlets
    
    private lazy var imagePhoto: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .brown
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var viewContainer: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var name: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines =  1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var actor: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.numberOfLines =  1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [name, actor])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.setCustomSpacing(5, after: name)
        stack.setCustomSpacing(5, after: actor)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarhy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupHierarhy() {
        contentView.addSubview(viewContainer)
        viewContainer.addSubview(imagePhoto)
        contentView.addSubview(stack)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            viewContainer.heightAnchor.constraint(equalToConstant: 80),
            viewContainer.widthAnchor.constraint(equalToConstant: 80),
            viewContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10),
            viewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            
            imagePhoto.heightAnchor.constraint(equalToConstant: 80),
            imagePhoto.widthAnchor.constraint(equalToConstant: 60),
            
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stack.leftAnchor.constraint(equalTo: viewContainer.leftAnchor, constant: 100),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30)
        ])
    }
}
