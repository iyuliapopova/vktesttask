//
//  Hero.swift
//  DetailMaster
//
//  Created by Yulia Popova on 4/4/2022.
//

import Foundation

struct Hero: Codable {
   let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let gender: String?
    let origin: Origin?
    let location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}
