//
//  TranslatorService.swift
//  Pokedex
//
//  Created by Séllyei Bence on 2022. 10. 28..
//

import Foundation
import GoogleTranslateSwift

class TranslatorService: TranslatorServiceProtocol {
    private let service: GoogleTranslateApiService
    
    @Inject private var translatorCacheService: TranslatorCacheService
    
    init(apiKey: String) {
        service = GoogleTranslateApiService(apiKey: apiKey)
    }
    
    func translate(text: String, completion: @escaping ([String]) -> Void) {
        if translatorCacheService.cacheContains(key: text) {
            if let texts = translatorCacheService.loadFromCache(key: text) {
                completion(texts)
            }
        } else {
            let english = Locale(identifier: "en")
            let hungarian = Locale(identifier: "hu")
            
            service.translate(text, from: english, to: hungarian) { result in
                if result.isSuccess {
                    if let success = result.successResult {
                        var results: [String] = []
                        for translation in success.translations {
                            results.append(translation.translatedText)
                        }
                        
                        self.translatorCacheService.addToCache(key: text, value: results)
                        
                        DispatchQueue.main.async {
                            completion(results)
                        }
                    }
                } else if result.isFailure {
                    if let error = result.failureError {
                        self.handleError(error)
                    }
                }
            }
        }
    }
    
    private func handleError(_ error: Error) {
        print("----------ERROR IN TRANSLATORSERVICE: TRANSLATE----------")
        print(error.localizedDescription)
        print("----------ERROR END----------")
    }
}
