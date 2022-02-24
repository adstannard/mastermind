import SwiftUI

struct InstructionsView: View {
    
    @Binding var showNumbers: Bool
    private let background = Color(red: 0.0, green: 0.2, blue: 0.2)
    private let colors = [Color.red, Color.orange, Color.blue, Color.green, Color.yellow, Color.purple]
    
    
    var body: some View {
        
        let numbers = [3,0,2,0,4]
        let code = numbers.map {(index) -> Color in colors[index]}
        
        ZStack {
            Rectangle().foregroundColor(background).ignoresSafeArea()
            ScrollView{
                VStack(alignment: .leading){
                    Group {
                        Text("Object").font(.title)
                        Text("Guess the color code in the fewest tries possible.")
                        Text("After each try clues will be given to you to help you crack the code.")
                        Divider().background(Color.accentColor)
                        Text("Gameplay").font(.title)
                        Text("Assign colors to the empty slots by tapping on the color buttons and confirm your guess with the check button once all slots from each try are filled.")
                        Text("Each element in the code is evaluated and hints are given as follows:")
                        HStack{
                            Circle()
                                .frame(width: 6, height: 6)
                                .foregroundColor(.red)
                            Text(": one right color in the right place")
                        }
                        HStack{
                            Circle()
                                .frame(width: 6, height: 6)
                                .foregroundColor(.white)
                            Text(": one right color in the wrong place")
                            
                        }
                        
                    }
                    Group {
                        HStack{
                            Circle()
                                .frame(width: 6, height: 6)
                                .foregroundColor(.gray)
                            Text(": one wrong color")
                        }
                        Text("The above clues are not given in any particular order. You must guess which clue element corresponds to which")
                    }
                    Divider().background(Color.accentColor)
                    Text("Example").font(.title)
                    HStack{
                        VStack{
                            HStack{
                                ForEach(0..<5)  {
                                    ColorButton(fill: Binding.constant(code[$0]),
                                                stroke: Binding.constant(code[$0]),
                                                content: Binding.constant(showNumbers ? String(numbers[$0]+1) : ""),
                                                selected: Binding.constant(false))
                                        .padding(.horizontal, 3).font(.system(size: 17))
                                    
                                }}
                            
                            Divider().background(Color.accentColor).padding(.horizontal, 40)
                            
                            AttemptView(selected: Binding.constant(5),
                                        attempt: Binding.constant(0),
                                        currentAttempt: Binding.constant(0),
                                        feedback: Binding.constant([[.red,.white,.white,.gray,.gray]]),
                                        codeSize: Binding.constant(5),
                                        attemptColors: Binding.constant([[.green,.yellow,.yellow,.purple,.blue]]), attemptNumbers: showNumbers ? Binding.constant([["4","5","5","6","3"]]) :  Binding.constant([["","","","",""]]),
                                        isReadyToSubmit: Binding.constant(true),
                                        showNumbers: $showNumbers
                            ).disabled(true).font(.system(size: 17))
                        }
                    }
                    Spacer()
                }
            }
            .foregroundColor(.accentColor)
            .padding()
            .font(.title3)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("How to Play").font(.system(size: 30)).foregroundColor(.accentColor)
                    }
                }
            }
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView(showNumbers: Binding.constant(true))
    }
}
