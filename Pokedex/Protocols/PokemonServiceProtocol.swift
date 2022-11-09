//
//  PokemonServiceProtocol.swift
//  Pokedex
//
//  Created by Séllyei Bence on 2022. 10. 28..
//

import Foundation

protocol PokemonServiceProtocol {
    func getPokemon(id: Int, completion: @escaping (PokemonDto) -> Void)
}
