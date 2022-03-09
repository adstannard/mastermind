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
    
    @AppStorage("sound") private var sound = DefaultSettings.sound
    @AppStorage("showNumbers") private var showNumbers = DefaultSettings.showNumbers
    @AppStorage("timed") private var timed = DefaultSettings.timed
    @AppStorage("selectedRight") private var selectedRight = DefaultSettings.selectedRight
    
    @Binding var shouldPopToRootView : Bool
    @Binding var minutes: Int
    @Binding var seconds: Int
    @Binding var showPopUp: Bool
    @Binding var won: Bool
    @Binding var lost: Bool
    @Binding var difficulty: Difficulty
    @Binding var ran: [Int]
    
    
    var body: some View {
        // initialize code with colors based on random color indexes
        let code = ran.map {(index) -> Color in colors[index]}
        
        ZStack {
            Rectangle().foregroundColor(background).ignoresSafeArea()
            
                VStack {
                    Spacer(minLength: 30)
                    Group {
                        HStack(alignment: .center){
                            // secret code
                            ForEach(0..<difficulty.codeSize)  {
                                // hide code
                                if (hidden && !lost && !won){
                                    ColorButton(fill: Binding.constant(Color.clear),
                                                stroke: Binding.constant(Color.gray),
                                                content: Binding.constant("?"),
                                                selected: Binding.constant(false))
                                }
                                // reveal code
                                else {
                                    ColorButton(fill: Binding.constant(code[$0]),
                                                stroke: Binding.constant(code[$0]),
                                                content: Binding.constant(showNumbers ? String(ran[$0]+1) : ""),
                                                selected: Binding.constant(false))
                                }
                            }
                            
                            // temporary button to reveal secret code
                            Button(action: {
                                
                                // tap sound effect
                                SoundManager.instance.playSound(soundEffect: hidden ? .reveal : .hide )
                                
                                // reveal/hide code
                                hidden.toggle()
                            }){
                                Image(systemName: hidden ? "eye" : "eye.slash")
                            }
                        }
                    }
                    Spacer(minLength: 60)
                    ScrollView{
                    HStack{
                        if (selectedRight){
                            // place list of attempts to the left of color selector
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
                                                isReadyToSubmit: $isReadyToSubmit
                                    )
                                }
                            }
                        }
                        Spacer()
                        
                        // color selector and submit attempt button
                        VStack{
                            ColorSelectorView(numColors: $difficulty.numColors,
                                              attempt: $currAttempt,
                                              attemptColors: $attemptColors,
                                              selected: $selected,
                                              codeSize: $difficulty.codeSize,
                                              isReadyToSubmit: $isReadyToSubmit,
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
                            // place list of attempts to the right of color selector
                            VStack(alignment: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/){
                                ForEach(0..<difficulty.maxAttempts){
                                    AttemptView(selected: $selected,
                                                attempt: Binding.constant($0),
                                                currentAttempt: $currAttempt,
                                                feedback: $feedback,
                                                codeSize: $difficulty.codeSize,
                                                attemptColors: $attemptColors,
                                                attemptNumbers: $attemptNumbers,
                                                isReadyToSubmit: $isReadyToSubmit
                                    )
                                }
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                }
            }
            
            // end game popup
            PopUpWindow(show: $showPopUp,
                        shouldPopToRootView: $shouldPopToRootView,
                        title: won ? "TitleWon" : "TitleLost",
                        subTitle: won ? "SubTitleWon" : "SubTitleLost",
                        time: timed ? String(format: "%d:%02d", minutes, seconds) : "",
                        attempt: currAttempt)
        }
    }
    
    // check attempt, check if game was won or lost, and advance to next attempt
    func checkCode(code: [Color], attempt: Int, attemptColors: [[Color]]) {
        
        // tap sound effect
        SoundManager.instance.playSound(soundEffect: .tap1)
        
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
            hidden = false
            showPopUp = true
            SoundManager.instance.playSound(soundEffect: .win)
        }
        
        // lost game
        if (currAttempt >= difficulty.maxAttempts-1 && right != difficulty.codeSize){
            lost = true
            hidden = false
            showPopUp = true
            SoundManager.instance.playSound(soundEffect: .lose)
        }
        
        // advance to next attempt and reset values accordingly
        currAttempt += 1
        selected = 0
        isReadyToSubmit = false
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(shouldPopToRootView:  Binding.constant(false),
                 minutes:Binding.constant(2),
                 seconds: Binding.constant(0),
                 showPopUp: Binding.constant(false),
                 won: Binding.constant(false),
                 lost: Binding.constant(false),
                 difficulty: Binding.constant(Difficulty(maxAttempts: 12, codeSize: 6, numColors: 8, difficulty: "Easy", color: .blue)),
                 ran: Binding.constant([1,0,2,2,3,6]))
    }
}
