//
//  JokeViewModel.swift
//  JokeApp
//
//  Created by Philipp Böhm on 28.05.24.
//

import Foundation
import AVFoundation // For Text-to-Speech Conversion

class JokeViewModel: ObservableObject {
    @Published var fetchedJoke: Joke?
    @Published var errorMessage: String?
    private var synthesizer = AVSpeechSynthesizer() // Instance of Text-to-Speech Synthesizer
    @Published var selectedLanguage: String = "🇺🇸" // Default-Language for fetching jokes is english
    @Published var selectedCategory: String = "None" // Default-Category is "Any" => No category is set
    @Published var safeMode: Bool = false // Safe Mode is disabled by default
    
    // Fetching Jokes
    func fetchJoke() {
        Task {
            do {
                let fetchedJokeData = try await fetchJokeData()
                DispatchQueue.main.async { // execute on the main thread
                    self.fetchedJoke = fetchedJokeData // jokeViewModel.fetchedJoke gets assigned the fetched Joke data
                    
                    if self.synthesizer.isSpeaking { // Speech is stoped when new joke is fetched
                        self.synthesizer.stopSpeaking(at: .immediate)
                    }
                }
            } catch { // If error is thrown of fetchJokeData()
                DispatchQueue.main.async { // execute on the main thread
                    self.errorMessage = "Fehler beim Laden der Daten: \(error.localizedDescription)" // Error Message gets updated
                    self.fetchedJoke = nil // last fetched Joke gets removed
                }
            }
        }
    }
    
    // Building URL to fetch desired JokeData
    private func fetchJokeData() async throws -> Joke {
        let baseUrl: String = "https://v2.jokeapi.dev/joke/" // BaseURL of Joke REST-API (documentation: https://sv443.net/jokeapi/v2/)
        var catUrl: String = ""
        var safeUrl: String = ""
        var jokeUrl: String = ""
        
        switch selectedCategory { // Building catURL
        case "Programming":
            catUrl = baseUrl + "Programming?"
        case "Miscellaneous":
            catUrl = baseUrl + "Miscellaneous?"
        case "Dark":
            catUrl = baseUrl + "Dark?"
        case "Pun":
            catUrl = baseUrl + "Pun?"
        case "Spooky":
            catUrl = baseUrl + "Spooky?"
        case "Christmas":
            catUrl = baseUrl + "Christmas?"
        default:
            catUrl = baseUrl + "Any?"
        }
        
        if safeMode { // Building safeURL
            safeUrl = catUrl + "safe-mode"
        } else {
            safeUrl = catUrl
        }
        
        if selectedLanguage == "🇩🇪" { // Building final jokeURL
            jokeUrl = safeUrl + "&lang=de"
        } else {
            jokeUrl = safeUrl
        }
        
        print("URL String: \(jokeUrl)") // For Debugging
        
        guard let url = URL(string: jokeUrl) else { // Safely build url
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url) // Fetch JokeData with built url
        return try JSONDecoder().decode(Joke.self, from: data) // Decode fetched JSON-Data to same datastructure as defined in Joke.swift
    }
    
    // Reading the Joke out loud
    func speakJoke() {
        
        if AVAudioSession.sharedInstance().category != .playback { // Setup AudioSession
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
            } catch let error {
                print("ERROR:", error.localizedDescription)
            }
        }
        
        guard let theJoke = fetchedJoke else { return } // Safely unwrap Joke
        
        // Set Text that has to be spoken
        var utteranceText: AVSpeechUtterance?
        if theJoke.type == "twopart" {          // Safely unwrap twopart-joke
            if let setup = theJoke.setup, let delivery = theJoke.delivery {
                let joke = setup + " " + delivery // Build twopart-joke to onepart joke for easier reading
                utteranceText = AVSpeechUtterance(string: joke) // Set Speech
            }
        } else {
            if let joke = theJoke.joke {        // Safely unwrap onepart-joke
                utteranceText = AVSpeechUtterance(string: joke) // Set Speech
            }
        }
        
        guard let utterance = utteranceText else { return } // Safely unwrap ReadingText
        
        // Set Reading-Language (If the english voice reads German Jokes it sounds like sh.. and vice versa)
        if theJoke.lang == "en" {
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        } else {
            utterance.voice = AVSpeechSynthesisVoice(language: "de-DE")
        }
        
        synthesizer.speak(utterance)    // Read Joke
    }
    
}
