//
//  GameModeLink.swift
//  Mastermind
//
//  Created by Leanet Alfonso Azcona on 2/23/22.
//

import SwiftUI

struct GameModeLink: View {
    
    @Binding var sound: Bool
    @Binding var showNumbers: Bool
    @Binding var duplicateColors: Bool
    @Binding var timed: Bool
    @Binding var selectedRight: Bool
    @Binding var difficulty: Difficulty
    
    
    func generateRandom(size: Int, max: Int) -> [Int] {
        (0..<size).map( {_ in Int.random(in: 0..<max)} )
    }
    
    func generateUniqueRandom(size: Int, max: Int) -> [Int] {
        
        precondition(size < max, "Cannot generate a list of \(size) unique numbers, if they all have to be less than \(max)")
        
        var set = Set<Int>()
        var array = [Int]()
        
        while set.count < size {
            let randomNumber = Int.random(in: 0..<max)
            if (set.insert(randomNumber).inserted){
                array.append(randomNumber)
            }
        }
        return array
    }
    
    
    var body: some View {
        NavigationLink(destination: GameView(difficulty: $difficulty,
                                             ran: Binding.constant(duplicateColors ? generateRandom(size: difficulty.codeSize, max: difficulty.numColors) : generateUniqueRandom(size: difficulty.codeSize, max: difficulty.numColors)),
                                             selectedRight: $selectedRight,
                                             showNumbers: $showNumbers)) {
            ModeButton(difficulty: $difficulty.difficulty,
                       color: $difficulty.color)
        }
    }
}

struct GameModeLink_Previews: PreviewProvider {
    static var previews: some View {
        GameModeLink(sound: Binding.constant(false),
                     showNumbers: Binding.constant(true),
                     duplicateColors: Binding.constant(false),
                     timed: Binding.constant(false),
                     selectedRight: Binding.constant(true),
                     difficulty: Binding.constant(Difficulty(maxAttempts: 8, codeSize: 4, numColors: 6, difficulty: "Easy", color: Color.blue)))
    }
}
