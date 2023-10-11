//
//  DetailView.swift
//  21-HW - HarryPotter-Alamofire
//
//  Created by 1234 on 09.10.2023.
//

import UIKit

final class DetailView: UIView {
    
    var data: [Characters] = []

    let globalQueue =  DispatchQueue.global(qos: .utility)

    var character: Characters? {
        didSet {
            name.text = "NAME:  \(character?.name ?? "unknown")."
            dateOfBirth.text = "DATE OF BIRTH:  \(character?.dateOfBirth ?? "unknown")."
            ancestry.text = "ANCESTRY:  \(character?.ancestry ?? "unknown")."
            house.text = "FACULTY OF HOGWARTS:  \(character?.house ?? "unknown")."
            patronus.text = "TYPE PATRONUS:  \(character?.patronus ?? "unknown")."
            eyeColour.text = "EYE COLOUR:  \(character?.eyeColour ?? "unknown")."
            hairColour.text = "HAIR COLOUR:  \(character?.hairColour ?? "unknown")."

            if  let imagePath = self.character?.image,
                let imageURL = URL(string: imagePath){

                globalQueue.async {
                    if let imageData = try? Data(contentsOf: imageURL){
                        DispatchQueue.main.async{
                            self.iconNew.image = UIImage(data: imageData )
                        }
                    }

                }
            } else {
                self.iconNew.image = UIImage(systemName: "person.fill")
                return
            }
        }
    }

    // MARK: - Outlets

    private lazy var iconNew: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .brown
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var viewContainerNew: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()

    private lazy var patronus: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines =  2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var house: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines =  2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var name: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines =  2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var dateOfBirth: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines =  2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var ancestry: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines =  2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var eyeColour: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines =  1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var hairColour: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines =  1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [name,dateOfBirth, ancestry,patronus,house, eyeColour, hairColour])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.setCustomSpacing(5, after: name)
        stack.setCustomSpacing(5, after: dateOfBirth)
        stack.setCustomSpacing(5, after: ancestry)
        stack.setCustomSpacing(5, after: patronus)
        stack.setCustomSpacing(5, after: house)
        stack.setCustomSpacing(5, after: eyeColour)
        stack.setCustomSpacing(5, after: hairColour)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupHierarhy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error in Cell")
    }
   
    // MARK: - Setup

    private func setupView() {
        self.backgroundColor = .brown
    }

    private func setupHierarhy() {
        self.addSubview(viewContainerNew)
        viewContainerNew.addSubview(iconNew)
        self.addSubview(stack)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            viewContainerNew.centerXAnchor.constraint(equalTo: centerXAnchor),
            viewContainerNew.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            viewContainerNew.widthAnchor.constraint(equalToConstant: 250),
            viewContainerNew.heightAnchor.constraint(equalToConstant: 400),

            iconNew.centerXAnchor.constraint(equalTo: viewContainerNew.centerXAnchor),
            iconNew.centerYAnchor.constraint(equalTo: viewContainerNew.centerYAnchor),
            iconNew.topAnchor.constraint(equalTo: viewContainerNew.topAnchor, constant: 3),
            iconNew.leftAnchor.constraint(equalTo: viewContainerNew.leftAnchor, constant: 3),

            stack.topAnchor.constraint(equalTo: viewContainerNew.bottomAnchor, constant: 50),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.widthAnchor.constraint(equalToConstant: 250),
            stack.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}

