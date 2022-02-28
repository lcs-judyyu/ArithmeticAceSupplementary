//
//  AdditionView.swift
//  ArithmeticAce
//
//  Created by Russell Gordon on 2022-02-08.
//

import SwiftUI

struct AdditionView: View {
    
    // MARK: Stored properties
    @Environment(\.scenePhase) var scenePhase
    
    @State var currentQuestion: PreviousQuesitons = PreviousQuesitons(augend: 0,
                                                                      addend: 0,
                                                                      inputGiven: "1234",
                                                                      correctSum: 0,
                                                                      answerCorrect: false)
    
    @State var augend = Int.random(in: 1...143)
    @State var addend = 0
    
    // This string contains whatever the user types in
    @State var inputGiven = ""
    
    // Has an answer been checked?
    @State var answerChecked = false
    
    // Was the answer given actually correct?
    @State var answerCorrect = false
    
    @State var previous: [PreviousQuesitons] = []
    
    // MARK: Computed properties
    // What is the correct sum?
    var correctSum: Int {
        return augend + addend
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            QuestionPresentationVIew(operation: "+", firstValue: augend, secondValue: addend)
            
            Divider()
            
            AnswerAndResultView(answerChecked: answerChecked, answerCorrect: answerCorrect, inputGiven: $inputGiven)
            
            ZStack {
                
                Button(action: {
                    
                    // Answer has been checked!
                    answerChecked = true
                    
                    // Convert the input given to an integer, if possible
                    guard let answerGiven = Int(inputGiven) else {
                        // Sadness, not a number
                        answerCorrect = false
                        return
                    }
                    
                    // Check the answer!
                    if answerGiven == correctSum {
                        // Celebrate! 👍🏼
                        answerCorrect = true
                    } else {
                        // Sadness, they gave a number, but it's correct 😭
                        answerCorrect = false
                    }
                    
                    currentQuestion = PreviousQuesitons(augend: augend,
                                                        addend: addend,
                                                        inputGiven: inputGiven,
                                                        correctSum: correctSum,
                                                        answerCorrect: answerCorrect)
                    
                    //add previous question to the list
                    previous.append(currentQuestion)
                    
                }, label: {
                    Text("Check Answer")
                        .font(.largeTitle)
                })
                    .padding()
                    .buttonStyle(.bordered)
                // Only show this button when an answer has not been checked
                    .opacity(answerChecked == false ? 1.0 : 0.0)
                
                Button(action: {
                    // Generate a new question
                    augend = Int.random(in: 1...143)
                    addend = Int.random(in: 1...144 - augend)
                    
                    // Reset properties that track what's happening with the current question
                    answerChecked = false
                    answerCorrect = false
                    
                    // Reset the input field
                    inputGiven = ""
                    
                }, label: {
                    Text("New question")
                        .font(.largeTitle)
                })
                    .padding()
                    .buttonStyle(.bordered)
                // Only show this button when an answer has been checked
                    .opacity(answerChecked == true ? 1.0 : 0.0)
                
            }
            
            // Reaction animation
            //            ReactionAnimationView(answerChecked: answerChecked,
            //                                  answerCorrect: answerCorrect)
            List(previous, id: \.self) { currentPrevious in
                HStack {
                    ZStack {
                        if currentPrevious.answerCorrect == true {
                            Text("\(currentPrevious.augend)") +
                            Text(" + ") +
                            Text("\(currentPrevious.addend)") +
                            Text(" = ") +
                            Text("\(currentPrevious.correctSum)")
                        } else {
                            Text("\(currentPrevious.augend)") +
                            Text(" + ") +
                            Text("\(currentPrevious.addend)") +
                            Text(" = ") +
                            Text("\(currentPrevious.inputGiven)") +
                            Text(" (" + "\(currentPrevious.correctSum)" + ")")
                        }
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                            .frame(width: 30, height: 30)
                        //        CONDITION      true  false
                            .opacity(currentPrevious.answerCorrect == true ? 1.0 : 0.0)
                        
                        Image(systemName: "x.square")
                            .foregroundColor(.red)
                            .frame(width: 30, height: 30)
                        //        CONDITION1         AND     CONDITION2         true  false
                        //       answerChecked = true     answerCorrect = false
                            .opacity(currentPrevious.answerCorrect == false ? 1.0 : 0.0)
                    }
                }
                .font(.title2)
            }
        }
        .task {
            addend = Int.random(in: 1...144 - augend)
            
            loadPrevious()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .active{
                print("Active")
            } else {
                print("Background")
                
                //permanently save the favourite list
                persistPrevious()
            }
        }
        .padding(.horizontal)
        .font(.system(size: 72))
        
    }
    //MARK: Functions
    //save data permanently
    func persistPrevious() {
        //get a location to save data
        let filename = getDocumentsDirectory().appendingPathComponent(savedPreviousLabel)
        print(filename)
        
        //try to encodr data to JSON
        do {
           let encoder = JSONEncoder()
            
            //configure the encoder to "pretty print" the JSON
            encoder.outputFormatting = .prettyPrinted
            
            //Encode the list of favourites
            let data = try encoder.encode(previous)
            
            //write JSON to a file in the filename location
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
            //see the data
            print("Save data to the document directory successfully.")
            print("=========")
            print(String(data: data, encoding: .utf8)!)
            
        } catch {
            print("Unable to write list of favourites to the document directory")
            print("=========")
            print(error.localizedDescription)
        }
    }
    
    func loadPrevious() {
        let filename = getDocumentsDirectory().appendingPathComponent(savedPreviousLabel)
        print(filename)
        
        do {
            //load raw data
           let data = try Data(contentsOf: filename)
            
            print("Save data to the document directory successfully.")
            print("=========")
            print(String(data: data, encoding: .utf8)!)
            
            //decode JSON into Swift native data structures
            //NOTE: [] are used since we load into an array
            previous = try JSONDecoder().decode([PreviousQuesitons].self, from: data)
            
        } catch {
            print("Could not loas the data from the stored JSON file")
            print("=========")
            print(error.localizedDescription)
        }
    }
}

struct AdditionView_Previews: PreviewProvider {
    static var previews: some View {
        AdditionView()
    }
}
