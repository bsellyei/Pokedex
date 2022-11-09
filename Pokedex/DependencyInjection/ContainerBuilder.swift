//
//  ContainerBuilder.swift
//  Pokedex
//
//  Created by Séllyei Bence on 2022. 10. 28..
//

import Foundation
import Swinject

func buildContainer() -> Container {
    let container = Container()
    
    container.register(PokemonServiceProtocol.self) { _ in
        return PokemonService()
    }
    .inObjectScope(.container)
    
    container.register(PokemonDtoGeneratorProtocol.self) { _ in
        return PokemonDtoGenerator()
    }
    .inObjectScope(.container)
    
    container.register(SpeechServiceProtocol.self) { _ in
        return SpeechService()
    }
    .inObjectScope(.container)
    
    container.register(TranslatorServiceProtocol.self) { _ in
        return TranslatorService(apiKey: getApiKey())
    }
    .inObjectScope(.container)
    
    container.register(PokemonCacheService.self) { _ in
        return PokemonCacheService(capacity: 15)
    }
    .inObjectScope(.container)
    
    container.register(TranslatorCacheService.self) { _ in
        return TranslatorCacheService(capacity: 30)
    }
    .inObjectScope(.container)
    
    return container
}

func getApiKey() -> String {
    guard let filePath = Bundle.main.path(forResource: "GoogleTranslator-Info", ofType: "plist") else {
      fatalError("Couldn't find file 'GoogleTranslator-Info.plist'.")
    }
    
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY' in 'GoogleTranslator-Info.plist'.")
    }
    
    return value
}
