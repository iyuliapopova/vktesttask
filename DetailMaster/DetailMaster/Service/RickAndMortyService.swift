//
//  RickAndMortyService.swift
//  DetailMaster
//
//  Created by Yulia Popova on 4/4/2022.
//

import UIKit
import Alamofire

class RickAndMortyService {
    
    static let shared = RickAndMortyService()
    
    func getPage(completion: @escaping (RickAndMorty?) ->()) {
        AF.request("https://rickandmortyapi.com/api/character").responseDecodable(of: RickAndMorty.self) { result in
            completion(result.value)
        }
    }

    static func getHero(index: Int, completion: @escaping (Hero?) -> ()) {
        AF.request("https://rickandmortyapi.com/api/character/\(index)").responseDecodable(of: Hero.self) { result in
            completion(result.value)
        }
    }

    static func getImage(url: String, completion: @escaping (UIImage?) ->()) {
        AF.request(url).response { result in
            completion(UIImage(data: result.data ?? Data()))
        }
    }
}
