//
//  CacheServiceProtocol.swift
//  Pokedex
//
//  Created by Séllyei Bence on 2022. 10. 28..
//

import Foundation

protocol CacheServiceProtocol {
    associatedtype K
    associatedtype V
    
    func cacheContains(key: K) -> Bool
    func loadFromCache(key: K) -> V?
    func addToCache(key: K, value: V)
}
