//
//  NamesResponse.swift
//  whichNationIsIt
//
//  Created by Umithan  on 18.08.2022.
//

import Foundation

struct NamesResponse: Codable {
    let name: String?
    let country: [Country]?
}
