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
}
