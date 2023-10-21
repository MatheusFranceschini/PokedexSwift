//
//  Pokemon.swift
//  Pokedex
//
//  Created by Matheus Franceschini on 21/10/23.
//
//https://pokeapi.co/api/v2/pokemon?limit=151

import Foundation

struct Pokemon: Codable {
    var results: [PokemonEntries]
}

struct PokemonEntries: Codable, Identifiable {
    let id = UUID()
    var name: String
    var url: String
}

class PokeAPI {
    func getData(completion: @escaping ([PokemonEntries]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else {
            return
        }
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let data = data else {
                return
            }
            
            let pokemonList = try! JSONDecoder().decode(Pokemon.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonList.results)
            }
        }.resume()
    }
}
