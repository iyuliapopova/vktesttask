//
//  Episodes.swift
//  DetailMaster
//
//  Created by Yulia Popova on 4/4/2022.
//

import Foundation

struct Episodes: Codable {
    let id: Int?
    let name: String?
    let airDate: String?
    let episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
}
