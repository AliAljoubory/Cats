//
//  Cats.swift
//  Cats
//
//  Created by Ali Aljoubory on 25/12/2020.
//

import UIKit

struct Cats: Codable, Hashable {
    
    var name: String?
    var temperament: String?
    var wikipediaUrl: String?
    var energyLevel: Int?
    var image: Image?
}

struct Image: Codable, Hashable {
    
    var url: String?
}
