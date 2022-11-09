//
//  SpeechService.swift
//  Pokedex
//
//  Created by Séllyei Bence on 2022. 10. 28..
//

import Foundation
import AVFoundation

class SpeechService: SpeechServiceProtocol {
    let synthetizer = AVSpeechSynthesizer()
    
    func speak(text: String, language: String) {
        let utterence = AVSpeechUtterance(string: text)
        utterence.voice = AVSpeechSynthesisVoice(language: language)
        
        synthetizer.speak(utterence)
    }
}
