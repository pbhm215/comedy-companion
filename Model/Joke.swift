//
//  JokeStore.swift
//  JokeApp
//
//  Created by Philipp Böhm on 27.05.24.
//

import Foundation

struct Joke: Codable { // Data Structure of a fetched Joke from JokeAPI (https://sv443.net)
    let error: Bool         // Error = true, if no Joke was found with selected Parameters
    let type: String        // "single" or "twopart"
    let joke: String?       // Single Joke
    let setup: String?      // Twopart Joke (1)
    let delivery: String?   // Twopart Joke (2)
    let lang: String        // "en-US" or "de-DE"
}
