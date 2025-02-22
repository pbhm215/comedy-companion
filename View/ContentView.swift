//
//  ContentView.swift
//  JokeApp
//
//  Created by Philipp Böhm on 26.05.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var jokeViewModel = JokeViewModel() // Creates Instance of JokeViewModel
    @State private var showSettings = false // Settings-Sheet initially disabled

    var body: some View {
        VStack {
            Text("ComedyCompanion")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 20)
            
            // Settings-Button
            HStack {
                Spacer()
                Button(action: {
                    showSettings.toggle() // Settings-Button
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.title)
                        .padding()
                }
            }
            
            Spacer()
            
            // Joke-Window
            VStack {
                if let theJoke = jokeViewModel.fetchedJoke { // If Joke was fetched => Show Joke
                    if theJoke.type == "twopart" { // Show Joke with Setup and Punchline
                        if let setup = theJoke.setup, let delivery = theJoke.delivery {
                            Text("Setup:")
                                .font(.title3)
                                .bold()
                            Text(setup)
                                .font(.headline)
                                .padding()
                            Text("Punchline:")
                                .font(.title3)
                                .bold()
                            Text(delivery)
                                .font(.headline)
                                .padding()
                        }
                    } else {
                        if let joke = theJoke.joke { // Show Joke as Joke
                            Text("Joke:")
                                .font(.title3)
                                .bold()
                            Text(joke)
                                .font(.headline)
                                .padding()
                        }
                    }
                } else if let error = jokeViewModel.errorMessage { // If no Joke => Show error-Message
                    Text("ERROR: \(error)")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.red)
                } else {    // If no Joke and no Error Message => Show Loading...
                    Text("Loading...")
                        .font(.headline)
                        .padding()
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 5)
            
            Spacer()
            
            // Buttons/Controls
            HStack(spacing: 20) {
                Button(action: jokeViewModel.fetchJoke) { // Button for Next Joke-Fetching
                    Label("Next Joke", systemImage: "arrow.right.circle.fill")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: jokeViewModel.speakJoke) { // Button for Reading the Joke
                    Label("Read for me", systemImage: "speaker.wave.2.fill")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(jokeViewModel.fetchedJoke == nil) // If no Joke => no Reading available
            }
            .padding(.bottom, 20)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .onAppear(perform: jokeViewModel.fetchJoke) // Joke gets initially fetched
        .sheet(isPresented: $showSettings) {
            SettingsView(jokeViewModel: jokeViewModel) // Toggled Settings-View gets shown as pop-up
        }
    }
}

#Preview("Englisch") { // There was also a Preview in German which has been removed because the System-Language in the Simulator can´t be changed by the app anyways
    ContentView()
        .environment(\.locale, Locale(identifier: "en"))
}
