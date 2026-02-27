//
//  ContentView.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 25/02/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            
            ScrollView {
                VStack(spacing: 20){
                    EmptyUsersView()
                }
                .navigationTitle("Users")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {true}){
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.red.opacity(0.7))
                        }
                    }
                }
            }
        }
    }
    
}

struct EmptyUsersView: View {
    var body: some View {
        
        VStack(spacing: 16) {
            Image(systemName: "figure.highintensity.intervaltraining.circle")
                .font(.system(size:60))
                .foregroundColor(.red.opacity(0.6))
            
            
            Text("No users yet")
                .font(.title2)
                .bold()
            
            Text("Tap + to add a new Beast")
                .foregroundColor(.secondary)
        }
        .padding(.top, 200)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
