//
//  DetailViewController.swift
//  DetailMaster
//
//  Created by Yulia Popova on 4/4/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var id = 0
    
    let service = RickAndMortyService.shared
    
    private struct UIConstants {
        static let spacing = 5.0
    }

    lazy var nameLabel : UILabel = {
        var label = UILabel()
        label.text = service.heroes[id].name
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    lazy var locationLabel : UILabel = {
        var label = UILabel()
        label.text = "Location: " + service.heroes[id].location!.name!
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        return label
    }()
    
    lazy var genderLabel : UILabel = {
        var label = UILabel()
        label.text = "Gender: " + service.heroes[id].gender!
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        return label
    }()
    
    lazy var originLabel : UILabel = {
        var label = UILabel()
        label.text = "Origin: " + service.heroes[id].origin!.name!
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        return label
    }()
    
    lazy var statusLabel : UILabel = {
        var label = UILabel()
        label.text = "Status: " + service.heroes[id].status!
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        return label
    }()
    
    lazy var imageView : UIImageView = {
        
        var imageView = UIImageView()
        imageView.layer.bounds.size.height = 200
        imageView.layer.bounds.size.width = 200
        imageView.image = service.heroesImages[id]
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        navigationController?.navigationItem.hidesBackButton = false
        
        let backButton = UIBarButtonItem(title: "< back",
                                         style: .done,
                                         target: self,
                                         action: #selector(popVC(sender:)))
        navigationController!.navigationItem.leftBarButtonItem = backButton
        
        let stack = UIStackView(arrangedSubviews: [imageView, nameLabel, locationLabel, genderLabel, originLabel, statusLabel])
        stack.axis = .vertical
        stack.spacing = UIConstants.spacing
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.spacing).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor,  constant: 50).isActive = true

    }
    
    @objc func popVC(sender: UIBarButtonItem) {
       navigationController?.popViewController(animated: true)
    }
}
