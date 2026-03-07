//
//  UserDetailView.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 26/02/26.
//

import Foundation
import SwiftUI
import SwiftData


struct UserDetailView: View {
    
    @Bindable var user: User
        
    @State private var showAddRoutine: Bool = false
    
    @State private var activeRoutine: Routine? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                    
                if user.routines.isEmpty {
                    EmptyRoutinesView()
                }
            }
            .navigationTitle("Rutinas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button { activeRoutine = Routine(name: "Xpartano") }  label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.green.opacity(0.8))
                    }
                }
            }
            .navigationDestination(item: $activeRoutine){ routine in
                    RoutineDetailView(routine: routine, user: user)
            }
        }
        
    }
    
    
}


struct EmptyRoutinesView: View {
    var body: some View {
        
        VStack(spacing: 16) {
            Image(systemName: "figure.strengthtraining.traditional.circle")
                .font(.system(size:60))
                .foregroundColor(.red.opacity(0.6))
            
            
            Text("Aún no hay Xpartanos")
                .font(.title2)
                .bold()
            
            Text("Toca + para agregar uno nuevo")
                .foregroundColor(.secondary)
        }
        .padding(.top, 200)
    }
}

#Preview {
     UserDetailView(
         user: User(photo: nil, name: "Cris", height: 180.0, weight: 79.0, gender: "Male", category: "Wild", age: 26)
     )
     .modelContainer(for: [User.self, Routine.self, ExcerciseSet.self], inMemory: true)
 }
