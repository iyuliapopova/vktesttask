//
//  ViewController.swift
//  DetailMaster
//
//  Created by Yulia Popova on 4/4/2022.
//


import UIKit
import Alamofire

class MasterViewController: UIViewController {

    private struct UIConstants {
        static let titleSize = 24.0
        static let height = 60.0
        static let rowHeight = 60.0
    }

    let service = RickAndMortyService.shared


    var areHeroesLoaded = false

    var nextPage : String? = nil
    var prevPage : String? = nil
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
        DispatchQueue.global(qos: .userInteractive).async {
            self.service.getPage { [self] result in
                print(result?.info?.count)
                service.heroes = result!.results!

                for hero in service.heroes {
                    RickAndMortyService.getImage(url: hero.image!) { image in
                        service.heroesImages.append(image!)
                        updatePatches()
                    }
                }
                areHeroesLoaded = true
                nextPage = result?.info?.next ?? nil
                prevPage = result?.info?.prev ?? nil
            }
         }

        if areHeroesLoaded {
            tableView.reloadData()
        }

        configureUI()
        self.tableView.reloadData()
    }

    private func configureUI() {

        self.title = "Rick and Morty"
        navigationController!.navigationBar.barTintColor = UIColor.white
        view.backgroundColor = UIColor.white
        navigationController!.navigationBar.tintColor = UIColor.white
        navigationController!.navigationItem.hidesBackButton = false
        navigationController!.navigationBar.standardAppearance.shadowColor = .white
        navigationController!.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.backgroundColor = UIColor.AppColors.accentColor

        let previousButton = UIBarButtonItem()
        previousButton.title = "Previous"
        previousButton.tintColor = UIColor.white
        previousButton.target = self
        previousButton.action = #selector(previous_)

        navigationItem.leftBarButtonItem = previousButton

        let nextButton = UIBarButtonItem()
        nextButton.title = "Next"
        nextButton.tintColor = UIColor.white
        nextButton.target = self
        nextButton.action = #selector(next_)

        navigationItem.rightBarButtonItem = nextButton
        
        
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rowHeight = UIConstants.rowHeight

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func updatePatches() {
        var numberOfSections = self.tableView.numberOfSections
        var numberOfRows = self.tableView.numberOfRows(inSection: numberOfSections-1)

        var patches : [IndexPath] = []
        
        for i in 0...19 {
            patches.append(IndexPath(row: i, section: 0))
        }

        tableView.reloadRows(at: patches, with: .none)
    }

    @objc func previous_() {
        if prevPage != nil {
            changePage(page: prevPage!)
        }
    }
    
    @objc func next_() {
        if nextPage != nil {
            changePage(page: nextPage!)
        }
    }
    
    func changePage(page: String) {
        service.getPage(url: page, completion: { [self] result in
            print(result?.info?.count)
            service.heroes = result!.results!
            service.heroesImages = []
            for hero in service.heroes {
                RickAndMortyService.getImage(url: hero.image!) { image in
                    service.heroesImages.append(image!)
                    updatePatches()
                }
            }
            nextPage = result?.info?.next ?? nil
            prevPage = result?.info?.prev ?? nil
            areHeroesLoaded = true
            tableView.reloadData()
        })
    }
}

extension MasterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12.0)
 
        if areHeroesLoaded {
            if indexPath.row < service.heroesImages.count {
                cell.imageView?.image = service.heroesImages[indexPath.row]
            }
            cell.textLabel?.text = service.heroes[indexPath.row].name
            cell.detailTextLabel?.text = String(service.heroes[indexPath.row].id!)

        } else {
            cell.textLabel?.text = "Loading..."
            cell.detailTextLabel?.text = "Loading..."
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        let detailViewController = DetailViewController()
        detailViewController.id = indexPath.row
        let controller = UINavigationController(rootViewController: detailViewController)
        controller.modalPresentationStyle = .fullScreen

        self.present(controller, animated: false)

    }
}
