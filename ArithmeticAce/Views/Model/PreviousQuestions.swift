//
//  PreviousQuestions.swift
//  ArithmeticAce
//
//  Created by Judy Yu on 2022-02-27.
//

import Foundation

struct PreviousQuesitons: Decodable, Hashable, Encodable {
    let firstValue: Int
    let secondValue: Int
    let inputGiven: String
    let correctAnswer: Int
    let answerCorrect: Bool
}
