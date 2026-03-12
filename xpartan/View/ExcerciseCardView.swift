//
//  ExcerciseCardView.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 12/03/26.
//

import SwiftUI

struct ExcerciseCardView: View {


    @State private var vm: ExcerciseCardViewModel
    
    init(excerciseSet: ExcerciseSet) {
        self.vm = ExcerciseCardViewModel(excerciseSet: excerciseSet)
    }

    
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 5) {
                
                
                HStack{
                    Image(systemName: "gauge.with.needle")
                        .foregroundStyle(vm.isRunning ? .green: .secondary)
                    Text(vm.formattedTime)
                        .font(.system(.title3, design: .monospaced))
                        .foregroundStyle(vm.isRunning ? .green : .secondary)
                    
                }
                
                Text(vm.excerciseName)
                    .font(.title2)
                    .bold()
                HStack {
                    Image(systemName:"dumbbell.fill")
                        .frame(width: .infinity, alignment: .leading)
                        .font(.title2)
                        .bold()
                    Text(vm.excerciseWeight)
                        .font(.title3)
                }
                
                HStack {
                    Image(systemName:"flag.pattern.checkered.circle")
                        .frame(width: .infinity, alignment: .leading)
                        .font(.title)
                        .bold()
                    
                    Text(vm.excerciseReps)
                        .font(.title3)
                        .bold()
                }
                
                
                
                HStack {
                    Text("Reps")
                        .frame(width: .infinity, alignment: .leading)
                        .font(.title3)
                        .bold()
                        .foregroundStyle(!vm.isRunning ? .secondary : .primary)
                    TextField("Reps", value: $vm.completedReps, format: .number)
                        .frame(width: .infinity, alignment: .leading)
                        .font(.title3)
                        .disabled(!vm.isRunning)
                        .foregroundStyle(!vm.isRunning ? .secondary : .primary)
                    
                    HStack {
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                vm.isRunning ? vm.stop() : vm.start()
                            }
                        
                        } label: {
                            Image(systemName: vm.isRunning ? "stop.circle.fill" : "play.circle.fill")
                                    .font(.title3)
                                    .foregroundStyle(vm.isRunning ? .red : .green)
                                    .scaleEffect(vm.isRunning ? 1.4 : 1.3)
                        }
                        
                    }
                }
                

            }
            .padding(.horizontal, 20)
            .frame(width: .infinity, height: 170)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .onChange(of: vm.resetTrigger) {
            vm.timer?.invalidate()
            vm.timer = nil
            vm.isRunning = false
            vm.completedReps = 0
        }
    }

}
