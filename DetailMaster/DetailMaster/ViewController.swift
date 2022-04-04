//
//  ViewController.swift
//  DetailMaster
//
//  Created by Yulia Popova on 4/4/2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    private struct UIConstants {
        static let titleSize = 24.0
        static let height = 60.0
        static let rowHeight = 60.0
    }
    
    let service = RickAndMortyService.shared
    
    var heroes : [Hero] = []
    private lazy var titleLabel = UILabel()
    var areHeroesLoaded = false
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.AppColors.tableColor
        table.dataSource = self
        table.delegate = self
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLineEtched
        return table
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.getPage { [self] result in
            print(result?.info?.count)
            self.heroes = result!.results!
            areHeroesLoaded = true
            tableView.reloadData()
            for hero in self.heroes {
                print(hero.name!)
                print(hero.id!)
            }
        }
        
        configureUI()
    }
    
    private func configureUI() {
        
        view.backgroundColor = UIColor.AppColors.accentColor
        
        titleLabel.text = "Rick And Morty"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
        titleLabel.backgroundColor = UIColor.AppColors.accentColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center

        
        view.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.height).isActive = true
        

        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.height).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rowHeight = UIConstants.rowHeight
        
        tableView.dataSource = self
        tableView.delegate = self
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12.0)

        if areHeroesLoaded {
            cell.textLabel?.text = heroes[indexPath.row].name
            cell.detailTextLabel?.text = heroes[indexPath.row].location!.name
        } else {
            cell.textLabel?.text = "Loading..."
            cell.detailTextLabel?.text = "Loading..."
        }
        return cell
    }
    
    
}
