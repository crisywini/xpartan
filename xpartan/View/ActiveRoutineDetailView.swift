//
//  RoutineDetailView.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 27/02/26.
//

import Foundation
import SwiftUI
import SwiftData

struct ActiveRoutineDetailView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var vm: ActiveRoutineDetailViewModel
    
    init(routine: Routine, user: User) {
        self.vm = ActiveRoutineDetailViewModel(routine: routine, user: user)
    }
    

    var body: some View {

        ScrollView {

            VStack(spacing: 30) {
                VStack {
                    Text(
                        vm.formattedRoutineInfo
                    )
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    
                    Divider()
                                    .frame(height: 24)
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "gauge.with.needle")
                                        .foregroundStyle(.green)
                                        .font(.title3)
                                    Text(vm.formattedRoutineTime)
                                        .font(.system(.title3, design: .monospaced))
                                        .foregroundStyle(.green)
                                }
                    
                }
                let columns = [GridItem(.flexible()), GridItem(.flexible())]

                LazyVGrid(columns: columns, spacing: 16){
                    ForEach(vm.excerciseSets, id: \.self) { es in
                        ExcerciseCardView(
                            excerciseSet: es,
                            resetTrigger: vm.finishCount
                        )
                    }
                }
                
                HStack {
                    Button {
                        vm.finishRoutine(modelContext)
                    } label: {
                        
                        HStack {
                            Text("Finalizar")
                                .font(.title)
                                .bold()
                                .foregroundStyle(.black)
                            Image(systemName: "flag.pattern.checkered")
                                .font(.title)
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
            .navigationTitle("Xpartano")
        }
        .padding(.horizontal)
        .onAppear {
            vm.startRoutineTimer()
        }
        .onDisappear {
            vm.stopRoutineTimer()
        }

    }
    
    
    
    
    
}

#Preview {
    ActiveRoutineDetailView(routine: Routine(name: "Xpartano"), user: User(photo: nil, name: "Cris", height: 180.0, weight: 79.0, gender: "Male", category: "Wild", age: 26)
    )
        .modelContainer(for: [Routine.self, ExcerciseSet.self, Serie.self], inMemory: true)

}
