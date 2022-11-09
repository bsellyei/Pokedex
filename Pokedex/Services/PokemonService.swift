//
//  PokemonService.swift
//  Pokedex
//
//  Created by Séllyei Bence on 2022. 10. 27..
//

import Foundation
import PokemonAPI

class PokemonService: PokemonServiceProtocol {
    private var pokemonAPI: PokemonAPI
    @Inject private var pokemonDtoGenerator: PokemonDtoGeneratorProtocol
    @Inject private var pokemonCacheService: PokemonCacheService
    
    init() {
        pokemonAPI = PokemonAPI()
    }
    
    func getPokemon(id: Int, completion: @escaping (PokemonDto) -> Void) {
        if pokemonCacheService.cacheContains(key: id) {
            if let pokemonDto = pokemonCacheService.loadFromCache(key: id) {
                completion(pokemonDto)
            }
        } else {
            pokemonAPI.pokemonService.fetchPokemon(id) { result in
                switch result {
                case .success(let pokemon):
                    if let speciesResource = pokemon.species {
                        self.pokemonAPI.resourceService.fetch(speciesResource) { result in
                            switch result {
                            case .success(let species):
                                let pokemonDto = self.pokemonDtoGenerator.generate(pokemon: species, sprites: pokemon.sprites)
                                self.pokemonCacheService.addToCache(key: id, value: pokemonDto)
                                
                                DispatchQueue.main.async {
                                    completion(pokemonDto)
                                }
                                
                            case .failure(let error):
                                self.handleError(error)
                            }
                        }
                    }
                    
                case .failure(let error):
                    self.handleError(error)
                }
            }
        }
    }
    
    private func handleError(_ error: Error) {
        print("----------ERROR IN POKEMONSERVICE: GETPOKEMON----------")
        print(error.localizedDescription)
        print("----------ERROR END----------")
    }
}
