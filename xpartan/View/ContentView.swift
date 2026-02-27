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
    @Query private var users: [User]
    @State private var showingAddUser = false

    var body: some View {
        NavigationStack {
            
            ScrollView {
                VStack(spacing: 20){
                    
                    if users.isEmpty {
                        EmptyUsersView()
                    }
                }
                .navigationTitle("Bestiax")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {showingAddUser = true}){
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.red.opacity(0.7))
                        }
                    }
                }
                .sheet(isPresented: $showingAddUser){
                    AddUserView()
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
            
            
            Text("Aún no hay usuarios")
                .font(.title2)
                .bold()
            
            Text("Toca + para agregar una bestiax")
                .foregroundColor(.secondary)
        }
        .padding(.top, 200)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
