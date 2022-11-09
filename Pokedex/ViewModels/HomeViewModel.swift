//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Séllyei Bence on 2022. 10. 26..
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Inject private var pokemonService: PokemonServiceProtocol
    @Inject private var speechService: SpeechServiceProtocol
    @Inject private var translatorService: TranslatorServiceProtocol
    
    @Published var pokemon: PokemonDto
    
    @Published var languages: [String]
    @Published var selectedLanguage: String
    
    private let jigglypuffId = 39
    private var jigglypuff: PokemonDto
    
    init() {
        pokemon = PokemonDto()
        jigglypuff = PokemonDto()
        
        languages = ["en-US", "hu-HU"]
        selectedLanguage = "en-US"
    }
    
    func getPokemon() {
        let id = Int.random(in: 1...150)
        
        DispatchQueue.global(qos: .background).async {
            self.pokemonService.getPokemon(id: id) { pokemon in
                self.pokemon = pokemon
                self.speak()
            }
        }
    }
    
    func getJigglypuff() {
        if jigglypuff.name.isEmpty {
            DispatchQueue.global(qos: .background).async {
                self.pokemonService.getPokemon(id: self.jigglypuffId) { pokemon in
                    self.pokemon = pokemon
                    self.jigglypuff = pokemon
                    self.speak()
                }
            }
        } else {
            self.pokemon = jigglypuff
            self.speak()
        }
    }
    
    private func speak() {
        if needTranslation() {
            translate() { text in
                let speech = "\(self.pokemon.name). \(text)"
                self.speechService.speak(text: speech, language: self.selectedLanguage)
            }
        } else {
            let speech = "\(self.pokemon.name). \(self.pokemon.subName). \(self.pokemon.description)"
            self.speechService.speak(text: speech, language: self.selectedLanguage)
        }
    }
    
    private func needTranslation() -> Bool {
        return selectedLanguage == "hu-HU"
    }
    
    private func translate(onCompletion: @escaping (String) -> Void) {
        let textToTranslate = "\(self.pokemon.subName). \(self.pokemon.description)"
        DispatchQueue.global(qos: .background).async {
            self.translatorService.translate(text: textToTranslate) { texts in
                if let text = texts.first {
                    onCompletion(text)
                }
            }
        }
    }
}
