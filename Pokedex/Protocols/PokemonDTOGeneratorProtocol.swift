//
//  PokemonDTOGeneratorProtocol.swift
//  Pokedex
//
//  Created by Séllyei Bence on 2022. 10. 28..
//

import Foundation
import PokemonAPI

protocol PokemonDtoGeneratorProtocol {
    func generate(pokemon: PKMPokemonSpecies, sprites: PKMPokemonSprites?) -> PokemonDto
}
