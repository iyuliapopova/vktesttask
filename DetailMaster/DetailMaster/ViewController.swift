//
//  ViewController.swift
//  DetailMaster
//
//  Created by Yulia Popova on 4/4/2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let service = RickAndMortyService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.getPage { result in
            print(result)
        }
    }


}

