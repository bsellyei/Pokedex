//
//  CacheService.swift
//  Pokedex
//
//  Created by Séllyei Bence on 2022. 10. 28..
//

import Foundation

typealias PokemonCacheService = CacheService<Int, PokemonDto>
typealias TranslatorCacheService = CacheService<String, [String]>

class CacheService<T:Hashable, S>: CacheServiceProtocol {
    typealias K = T
    typealias V = S
    
    private var cache: [T:S]
    private let capacity: Int
    
    init(capacity: Int) {
        self.cache = [:]
        self.capacity = capacity
    }
    
    func cacheContains(key: T) -> Bool {
        return cache[key] != nil
    }
    
    func loadFromCache(key: T) -> S? {
        if let value = cache[key] {
            return value
        }
        
        return nil
    }
    
    func addToCache(key: T, value: S) {
        if cache.count == capacity {
            if let first = cache.first {
                cache[first.key] = nil
            }
            
            cache[key] = value
        } else {
            cache[key] = value
        }
    }
}
