//
//  Resolver.swift
//  Pokedex
//
//  Created by Séllyei Bence on 2022. 10. 28..
//

import Foundation
import Swinject

class Resolver {
    static let shared = Resolver()
    private var container = buildContainer()
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
    
    func setDependencyContainer(_ container: Container) {
        self.container = container
    }
}
