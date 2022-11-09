//
//  TranslatorServiceProtocol.swift
//  Pokedex
//
//  Created by Séllyei Bence on 2022. 10. 28..
//

import Foundation

protocol TranslatorServiceProtocol {
    func translate(text: String, completion: @escaping ([String]) -> Void)
}
