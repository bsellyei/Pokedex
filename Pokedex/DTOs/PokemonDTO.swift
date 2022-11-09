//
//  PokemonDTO.swift
//  Pokedex
//
//  Created by Séllyei Bence on 2022. 10. 28..
//

import Foundation

struct PokemonDto {
    let imageUrl: String
    let name: String
    let subName: String
    var description: String
    
    init() {
        imageUrl = ""
        name = ""
        subName = ""
        description = ""
    }
    
    init(imageUrl: String, name: String, subName: String, description: String) {
        self.imageUrl = imageUrl
        self.name = name
        self.subName = subName
        self.description = description
    }
}
