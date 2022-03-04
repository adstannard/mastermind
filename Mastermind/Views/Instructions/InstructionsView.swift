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
                        Text("Object_1").padding(.bottom, 1)
                        Text("Object_2")
                        Divider().background(Color.accentColor)
                        Text("Gameplay").font(.title)
                        Text("Gameplay_1").padding(.bottom, 1)
                        Text("Gameplay_2")
                        HStack{
                            FeedbackItem(color: .red, feedbackType: 1)
                            Text("Gameplay_3")
                        }
                        HStack{
                            FeedbackItem(color: .white, feedbackType: showNumbers ? 2 : 1)
                            Text("Gameplay_4")
                        }
                    }
                    Group {
                        HStack{
                            FeedbackItem(color: .gray, feedbackType: showNumbers ? 3 : 1)
                            Text("Gameplay_5")
                        }
                        Text("Gameplay_6")
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
            .font(.system(size: 18))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("How to play").font(.system(size: 30)).foregroundColor(.accentColor)
                    }
                }
            }
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView(showNumbers: Binding.constant(true)).environment(\.locale, Locale(identifier: "es"))
    }
}
