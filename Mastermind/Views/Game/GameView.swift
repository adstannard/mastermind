import SwiftUI

struct GameView: View {
    private let colors: [Color] = [Color.red, Color.orange, Color.blue, Color.green, Color.yellow, Color.purple, Color.mint, Color.white]
    private let background = Color(red: 0.0, green: 0.2, blue: 0.2)
    
    @State private var isReadyToSubmit = false
    @State private var attemptColors: [[Color]] = Array(repeating: Array(repeating: Color.clear, count: 6), count: 12)
    @State private var attemptNumbers: [[String]] = Array(repeating: Array(repeating: "", count: 6), count: 12)
    @State private var feedback: [[Color]] = Array(repeating: Array(repeating: Color.gray, count: 6), count: 12)
    @State private var currAttempt: Int = 0
    @State private var selected: Int = 0
    @State private var hidden: Bool = true
    
    @Binding var timed: Bool
    @Binding var minutes: Int
    @Binding var seconds: Int
    @Binding var showPopUp: Bool
    @Binding var won: Bool
    @Binding var lost: Bool
    @Binding var difficulty: Difficulty
    @Binding var ran: [Int]
    @Binding var selectedRight: Bool
    @Binding var showNumbers: Bool
    @Binding var selectedEnglish: Bool
    
    
    var body: some View {
        let code = ran.map {(index) -> Color in colors[index]}
        
        ZStack {
            Rectangle().foregroundColor(background).ignoresSafeArea()
            VStack {
                Spacer()
                Group {
                    HStack(alignment: .center){
                        ForEach(0..<difficulty.codeSize)  {
                            
                            if (hidden && !lost && !won){
                                ColorButton(fill: Binding.constant(Color.clear),
                                            stroke: Binding.constant(Color.gray),
                                            content: Binding.constant("?"),
                                            selected: Binding.constant(false))
                            }
                            else {
                                ColorButton(fill: Binding.constant(code[$0]),
                                            stroke: Binding.constant(code[$0]),
                                            content: Binding.constant(showNumbers ? String(ran[$0]+1) : ""),
                                            selected: Binding.constant(false))
                            }
                        }
                        
                        Button(action: {
                            hidden.toggle()
                        }){
                            Image(systemName: hidden ? "eye" : "eye.slash")
                        }
                    }
                }
                Spacer()
                HStack{
                    if (selectedRight){
                        Spacer()
                        
                        VStack(alignment: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/){
                            ForEach(0..<difficulty.maxAttempts){
                                AttemptView(selected: $selected,
                                            attempt: Binding.constant($0),
                                            currentAttempt: $currAttempt,
                                            feedback: $feedback,
                                            codeSize: $difficulty.codeSize,
                                            attemptColors: $attemptColors,
                                            attemptNumbers: $attemptNumbers,
                                            isReadyToSubmit: $isReadyToSubmit,
                                            showNumbers: $showNumbers
                                )
                            }
                        }
                    }
                    Spacer()
                    VStack{
                        ColorSelectorView(numColors: $difficulty.numColors,
                                          attempt: $currAttempt,
                                          attemptColors: $attemptColors,
                                          selected: $selected,
                                          codeSize: $difficulty.codeSize,
                                          isReadyToSubmit: $isReadyToSubmit,
                                          showNumbers: $showNumbers,
                                          attemptNumbers: $attemptNumbers)
                        
                        Button(action:{ checkCode(code: code,
                                                  attempt: currAttempt,
                                                  attemptColors: attemptColors)}){
                            ZStack {
                                Circle()
                                    .stroke(Color.accentColor, lineWidth: 2)
                                    .frame(width: 40, height: 40)
                                
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .frame(width: 20.0, height: 20.0).foregroundColor(.accentColor)
                            }.padding(.top)
                        }.disabled(!isReadyToSubmit)
                    }
                    Spacer()
                    if (!selectedRight){
                        VStack(alignment: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/){
                            ForEach(0..<difficulty.maxAttempts){
                                AttemptView(selected: $selected,
                                            attempt: Binding.constant($0),
                                            currentAttempt: $currAttempt,
                                            feedback: $feedback,
                                            codeSize: $difficulty.codeSize,
                                            attemptColors: $attemptColors,
                                            attemptNumbers: $attemptNumbers,
                                            isReadyToSubmit: $isReadyToSubmit,
                                            showNumbers: $showNumbers
                                )
                            }
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
            
            won ?
            PopUpWindow(show: $showPopUp, title: "You Win!", message: timed ? String(format: "Time left\n %d:%02d", minutes, seconds) : "Well done!")
            :
            PopUpWindow(show: $showPopUp, title: "You Lost!", message: timed ? String(format: "Time left\n %d:%02d", minutes, seconds) : "Better luck next time!")
        }
    }
    
    
    func checkCode(code: [Color], attempt: Int, attemptColors: [[Color]]) {
        
        // rightly positioned colors counter
        var right = 0
        
        // wrongly positioned colors counter
        var wrong = 0
        
        // modifiable copy of color code attempt
        var tempAttemptColors = attemptColors
        
        // modifiable copy of random color code
        var tempCode = code
        
        
        // count rightly positioned colors (red)
        for i in 0..<difficulty.codeSize {
            if (tempAttemptColors[attempt][i] == tempCode[i]){
                // increase right count
                right+=1
                
                // ignore color at index i for future checks
                tempAttemptColors[attempt][i] = Color.clear
                tempCode[i] = Color.black
            }
        }
        
        
        // count wrongly positioned colors (white)
        for i in 0..<difficulty.codeSize {
            for j in 0..<difficulty.codeSize {
                if (tempAttemptColors[attempt][j] == tempCode[i] && i != j){
                    // increase wrong count
                    wrong += 1
                    
                    // ignore color at index i for future checks
                    tempAttemptColors[attempt][j] = Color.clear
                    tempCode[i] = Color.black
                    break
                }
            }
        }
        
        
        // make first elements of feedback green accordingly
        for i in 0..<right {
            feedback[attempt][i] = Color.red
        }
        
        // make remaining elements of feedback red accordingly (rest stays gray)
        for i in 0..<wrong {
            feedback[attempt][i+right] = Color.white
        }
        
        // won game
        if (right == difficulty.codeSize){
            won = true
            showPopUp = true
            hidden = false
            
        }
        
        // lost game
        if ((currAttempt >= difficulty.maxAttempts-1 && right != difficulty.codeSize) || (
            minutes==0 && seconds==0)){
            lost = true
            hidden = false
        }
        
        // advance to next attempt and reset values accordingly
        currAttempt += 1
        selected = 0
        isReadyToSubmit = false
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(timed: Binding.constant(false),
                 minutes:Binding.constant(2),
                 seconds: Binding.constant(0),
                 showPopUp: Binding.constant(false),
                 won: Binding.constant(false),
                 lost: Binding.constant(false),
                 difficulty: Binding.constant(Difficulty(maxAttempts: 12, codeSize: 6, numColors: 8, difficulty: "Easy", color: .blue)),
                 ran: Binding.constant([1,0,2,2,3,6]),
                 selectedRight: Binding.constant(true),
                 showNumbers: Binding.constant(false),
                 selectedEnglish: Binding.constant(true))
    }
}
