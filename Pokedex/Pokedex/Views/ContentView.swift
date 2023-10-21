//
//  ContentView.swift
//  Pokedex
//
//  Created by Matheus Franceschini on 21/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var pokemon = [PokemonEntries]()
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchText == "" ? pokemon : pokemon.filter( {
                    $0.name.contains(searchText.lowercased())
                })) { entry in
                    HStack {
                        PokemonImageView(imageLink: "\(entry.url)")
                            .padding(.trailing, 20)
                        NavigationLink("\(entry.name)".capitalized, destination: Text("Detail View for \(entry.name)"))
                    }
                }
            }
            .onAppear {
                PokeAPI().getData() { pokemon in
                    self.pokemon = pokemon
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Pokedex")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
