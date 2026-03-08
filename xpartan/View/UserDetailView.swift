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
    
    @State private var vm: UserDetailViewModel
    
    init(user: User) {
        _vm = State(initialValue: UserDetailViewModel(user: user))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                    
                if vm.user.routines.isEmpty {
                    EmptyRoutinesView()
                } else {
                    
                }
            }
        }
        .navigationTitle("Rutinas")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button {
                    vm.createRoutine()
                }  label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.green.opacity(0.8))
                }
            }
        }
        .navigationDestination(item: $vm.activeRoutine){ routine in
            ActiveRoutineDetailView(routine: routine, user: vm.user)
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
