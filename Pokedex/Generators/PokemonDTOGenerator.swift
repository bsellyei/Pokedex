//
//  PokemonDTOGenerator.swift
//  Pokedex
//
//  Created by Séllyei Bence on 2022. 10. 28..
//

import Foundation
import PokemonAPI

class PokemonDtoGenerator: PokemonDtoGeneratorProtocol {
    private var languageType: String
    
    init() {
        languageType = "en"
    }
    
    func generate(pokemon: PKMPokemonSpecies, sprites: PKMPokemonSprites?) -> PokemonDto {
        var name: String = ""
        if let pkmName = pokemon.name {
            name = pkmName
        }
        
        var imageUrl: String = ""
        if let pkmSprites = sprites, let frontDefault = pkmSprites.frontDefault {
            imageUrl = frontDefault
        }
        
        var subName: String = ""
        if let generas = pokemon.genera {
            for genera in generas {
                if let genus = genera.genus, let language = genera.language, let languageName = language.name {
                    if languageName == "en" {
                        subName = genus
                    }
                }
            }
        }
        
        var description: String = ""
        if let flavorTexts = pokemon.flavorTextEntries {
            for text in flavorTexts {
                if let flavorText = text.flavorText, let language = text.language, let languageName = language.name {
                    if languageName == languageType {
                        description = flavorText
                        break
                    }
                }
            }
        }
        
        description = description.replacingOccurrences(of: "\n", with: " ")
        
        return PokemonDto(imageUrl: imageUrl, name: name, subName: subName, description: description)
    }
}
