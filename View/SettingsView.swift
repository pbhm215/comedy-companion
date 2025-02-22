//
//  SettingsView.swift
//  JokeApp
//
//  Created by Philipp Böhm on 02.06.24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var jokeViewModel: JokeViewModel // SettingsView uses Instance of JokeViewModel from ContentView
    private let categories = ["None", "Programming", "Miscellaneous", "Dark", "Pun", "Spooky", "Christmas"] // Gets set in List-Section "Category"

    var body: some View {
        NavigationView {
            List {
                
                // Setting of Language
                Section(header: Text("Language").font(.headline)) {
                    Button(action: {
                        jokeViewModel.selectedLanguage = (jokeViewModel.selectedLanguage == "🇺🇸") ? "🇩🇪" : "🇺🇸"
                    }) {
                        HStack {
                            Text("Language of Joke")
                                .foregroundColor(.black)
                            Spacer()
                            Text(jokeViewModel.selectedLanguage)
                                .font(.title)
                        }
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(20)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                
                // Setting of Safe Mode; Initial value: disabled
                Section(header: Text("Safe Mode").font(.headline)) {
                    Toggle(isOn: $jokeViewModel.safeMode) {
                        Text("Enable Safe Mode")
                    }
                }
                
                // Setting of Category; Initial value: "None"
                Section(header: Text("Category").font(.headline)) {
                    ForEach(categories, id: \.self) { category in
                        Button(action: {
                            jokeViewModel.selectedCategory = category
                        }) {
                            HStack {
                                Text(category)
                                Spacer()
                                if category == jokeViewModel.selectedCategory {
                                    Image(systemName: "checkmark") // Checkmark for selected Category
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .foregroundColor(.black)
                    }
                }

            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Settings")
        }
    }
}

#Preview("Englisch") { // There was also a Preview in German which has been removed because the System-Language in the Simulator can´t be changed by the app anyways
    SettingsView(jokeViewModel: JokeViewModel())
        .environment(\.locale, Locale(identifier: "en"))
}
