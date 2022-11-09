//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Séllyei Bence on 2022. 10. 26..
//

import SwiftUI

@main
struct PokedexApp: App {
    
    @StateObject var homeViewModel: HomeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
            }
            .environmentObject(homeViewModel)
        }
    }
}
