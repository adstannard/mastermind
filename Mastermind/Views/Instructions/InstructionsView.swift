import SwiftUI

struct InstructionsView: View {
    
    @AppStorage("showNumbers") private var showNumbers = DefaultSettings.showNumbers
    
    var body: some View {
        
        let numbers = [3, 0, 2, 0, 4]
        let code = numbers.map {(index) -> Color in Constants.colors[index]}
        
        ZStack {
            // background
            Color.theme.background.edgesIgnoringSafeArea(.all)
            
            ScrollView{
                VStack(alignment: .leading){
                    // Object
                    Group {
                        Text("Object").font(.title)
                        Text("Object_1").padding(.bottom, 1)
                        Text("Object_2")
                        Divider().background(Color.accentColor)
                    }
                    
                    // Gameplay
                    Group {
                        Text("Gameplay").font(.title)
                        Text("Gameplay_1").padding(.bottom, 1)
                        Text("Gameplay_2")
                        
                        // right color and position
                        HStack{
                            FeedbackItem(color: .red, feedbackType: 1)
                            Text("Gameplay_3")
                        }
                        // right color, wrong position
                        HStack{
                            FeedbackItem(color: .white, feedbackType: showNumbers ? 2 : 1)
                            Text("Gameplay_4")
                        }
                        // wrong color
                        HStack{
                            FeedbackItem(color: .gray, feedbackType: showNumbers ? 3 : 1)
                            Text("Gameplay_5")
                        }
                        
                        Text("Gameplay_6")
                        Divider().background(Color.accentColor)
                    }
                    
                    
                    // Example
                    Group {
                        Text("Example").font(.title)
                        HStack {
                            Spacer()
                            VStack {
                                // secret code
                                HStack {
                                    ForEach(0..<5) {
                                        ColorButton(fill: Binding.constant(code[$0]),
                                                    stroke: Binding.constant(code[$0]),
                                                    content: Binding.constant(showNumbers ? String(numbers[$0]+1) : ""),
                                                    selected: Binding.constant(false))
                                            .padding(.horizontal, 3).font(.system(size: 17))
                                    }
                                }
                                Divider().frame(width: 260).background(Color.accentColor)
                                
                                // sample attempt with feedback
                                AttemptView(selected: Binding.constant(5),
                                            attempt: Binding.constant(0),
                                            currentAttempt: Binding.constant(0),
                                            feedback: Binding.constant([[.red,.white,.white,.gray,.gray]]),
                                            codeSize: Binding.constant(5),
                                            attemptColors: Binding.constant([[Constants.colors[3],Constants.colors[4],Constants.colors[4],Constants.colors[5],Constants.colors[2]]]), attemptNumbers: showNumbers ? Binding.constant([["4","5","5","6","3"]]) :  Binding.constant([["","","","",""]])
                                ).disabled(true).font(.system(size: 17))
                            }
                            Spacer()
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
                // screen title
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
        InstructionsView()
    }
}
