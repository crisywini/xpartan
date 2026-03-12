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
    
    private var vm: ActiveRoutineDetailViewModel
    
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
                        vm.finishRoutine()
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
            vm.setContext(modelContext)
            
            vm.routineTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                vm.routineElapsedTime += 1
            }
        }
        .onDisappear {
            vm.routineTimer?.invalidate()
            vm.routineTimer = nil
        }

    }
    
    
    
    
    
}

struct ExcerciseCardView: View {

    @Bindable var excerciseSet: ExcerciseSet

    @State private var isCompleted = false
    @State private var isRunning = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer? = nil

    @State private var completedReps = 0

    let resetTrigger: Int



    var formattedTime: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 5) {
                
                
                HStack{
                    Image(systemName: "gauge.with.needle")
                        .foregroundStyle(isRunning ? .green: .secondary)
                    Text(formattedTime)
                        .font(.system(.title3, design: .monospaced))
                        .foregroundStyle(isRunning ? .green : .secondary)
                    
                }
                
                Text(excerciseSet.excercise.name)
                    .font(.title2)
                    .bold()
                HStack {
                    Image(systemName:"dumbbell.fill")
                        .frame(width: .infinity, alignment: .leading)
                        .font(.title2)
                        .bold()
                    Text(String(format: "%.f kg", excerciseSet.weight))
                        .font(.title3)
                }
                
                HStack {
                    Image(systemName:"flag.pattern.checkered.circle")
                        .frame(width: .infinity, alignment: .leading)
                        .font(.title)
                        .bold()
                    
                    Text("\(excerciseSet.completedReps) Reps")
                        .font(.title3)
                        .bold()
                }
                
                
                
                HStack {
                    Text("Reps")
                        .frame(width: .infinity, alignment: .leading)
                        .font(.title3)
                        .bold()
                        .foregroundStyle(!isRunning ? .secondary : .primary)
                    TextField("Reps", value: $completedReps, format: .number)
                        .frame(width: .infinity, alignment: .leading)
                        .font(.title3)
                        .disabled(!isRunning)
                        .foregroundStyle(!isRunning ? .secondary : .primary)
                    
                    HStack {
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                    isRunning ? stop() : start()
                            }
                        
                        } label: {
                            Image(systemName: isRunning ? "stop.circle.fill" : "play.circle.fill")
                                    .font(.title3)
                                    .foregroundStyle(isRunning ? .red : .green)
                                    .scaleEffect(isRunning ? 1.4 : 1.3)
                        }
                        
                    }
                }
                

            }
            .padding(.horizontal, 20)
            .frame(width: .infinity, height: 170)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .onChange(of: resetTrigger) {
            timer?.invalidate()
            timer = nil
            isRunning = false
            completedReps = 0
        }
    }

    func start() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedTime += 1
        }
    }

    func stop() {
        isRunning = false
        timer?.invalidate()
        timer = nil

        let setNumber = excerciseSet.serie.filter { $0.isCompleted }.count + 1
        let targetReps = excerciseSet.serie.first?.targetReps ?? 0
        let weight = excerciseSet.serie.first?.weight ?? 0

        excerciseSet.serie.append(Serie(
            setNumber: setNumber,
            targetReps: targetReps,
            completedReps: completedReps,
            weight: weight,
            duration: elapsedTime,
            isCompleted: true
        ))
        completedReps = 0
    }
}

#Preview {
    ActiveRoutineDetailView(routine: Routine(name: "Xpartano"), user: User(photo: nil, name: "Cris", height: 180.0, weight: 79.0, gender: "Male", category: "Wild", age: 26)
    )
        .modelContainer(for: [Routine.self, ExcerciseSet.self, Serie.self], inMemory: true)

}
