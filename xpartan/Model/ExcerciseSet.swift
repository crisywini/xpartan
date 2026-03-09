//
//  ExcerciseSet.swift
//  xpartan
//
//  Created by Cristian Sánchez Pineda on 26/02/26.
//

import Foundation
import SwiftData

@Model
final class ExcerciseSet {
    
    var excercise: Excercise
    var serie: [Serie]
    
    
    init(excercise: Excercise) {
        self.excercise = excercise
        self.serie = []
    }

    var duration: TimeInterval {
        serie.reduce(0) { $0 + $1.duration }
    }

    var completedReps: Int {
        serie.map { $0.completedReps }.reduce(0, +)
    }
    
    var weight: Double {
        serie.first?.weight ?? 0.0
    }

}
