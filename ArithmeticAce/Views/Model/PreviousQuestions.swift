//
//  PreviousQuestions.swift
//  ArithmeticAce
//
//  Created by Judy Yu on 2022-02-27.
//

import Foundation

struct PreviousQuesitons: Decodable, Hashable, Encodable {
    let augend: Int
    let addend: Int
    let inputGiven: String
    let correctSum: Int
    let answerCorrect: Bool
}
