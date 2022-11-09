//
//  HomeView.swift
//  Pokedex
//
//  Created by Séllyei Bence on 2022. 10. 26..
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: homeViewModel.pokemon.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Image("PokeBallIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            }
            .onTapGesture(perform: homeViewModel.getPokemon)
            
            if !homeViewModel.pokemon.name.isEmpty {
                HStack {
                    Text(homeViewModel.pokemon.name)
                        .fontWeight(.semibold)
                        .font(.title)
                }
            }
                
            Button(action: homeViewModel.getJigglypuff) {
                Text("🎤Jigglypuff")
                    .fontWeight(.semibold)
                    .font(.title)
            }
            .frame(minWidth: 0, maxWidth: 250)
            .padding()
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(40)
        }
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Picker("", selection: $homeViewModel.selectedLanguage) {
                    ForEach(homeViewModel.languages, id: \.self) {
                        Text($0)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
