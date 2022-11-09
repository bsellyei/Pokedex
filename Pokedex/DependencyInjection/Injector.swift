//
//  Injector.swift
//  Pokedex
//
//  Created by Séllyei Bence on 2022. 10. 28..
//

import Foundation

@propertyWrapper
struct Inject<Component> {
    let wrappedValue: Component
    
    init() {
        self.wrappedValue = Resolver.shared.resolve(Component.self)
    }
}
