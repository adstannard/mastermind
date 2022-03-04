import SwiftUI

struct GameModeLink: View {
    @Binding var shouldPopToRootView : Bool
    @Binding var sound: Bool
    @Binding var showNumbers: Bool
    @Binding var duplicateColors: Bool
    @Binding var timed: Bool
    @Binding var selectedRight: Bool
    @Binding var difficulty: Difficulty
    @Binding var ran: [Int]
    
    @State var minutes: [Int] = [3, 4]
    @State var seconds: Int = 0
    @State var showPopUp: Bool = false
    @State var lost: Bool = false
    @State var won: Bool = false
    
    @State private var action: Int? = 0
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationLink(destination: GameView(shouldPopToRootView: $shouldPopToRootView,
                                             timed: $timed,
                                             minutes: $minutes[difficulty.difficulty == "Easy" ? 0 : 1],
                                             seconds: $seconds,
                                             showPopUp: $showPopUp,
                                             won: $won,
                                             lost: $lost,
                                             difficulty: $difficulty,
                                             ran: $ran,
                                             selectedRight: $selectedRight,
                                             showNumbers: $showNumbers
                                            )
                        .foregroundColor(.accentColor)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("")
                        .toolbar {
            
            ToolbarItem(placement: .principal) {
                if (timed){
                    HStack {
                        VStack{
                            Text("time").font(.system(size: 13)).foregroundColor(.accentColor)
                            TimerView(minutes: $minutes,
                                      seconds: $seconds,
                                      i: (difficulty.difficulty == "Easy") ? Binding.constant(0) : Binding.constant(1),
                                      showPopUp: $showPopUp,
                                      lost: $lost,
                                      won: $won)
                        }
                    }.fixedSize(horizontal: true, vertical: true)
                }
            }
            
            ToolbarItem(placement: .automatic) {
                Button (action: { shouldPopToRootView = false } ){
                    Image(systemName: "plus.square")
                }
            }
        }){
            ModeButton(difficulty: $difficulty.difficulty,
                       color: $difficulty.color)
        }
    }
}


struct GameModeLink_Previews: PreviewProvider {
    static var previews: some View {
        GameModeLink(shouldPopToRootView: Binding.constant(false),
                     sound: Binding.constant(false),
                     showNumbers: Binding.constant(true),
                     duplicateColors: Binding.constant(false),
                     timed: Binding.constant(false),
                     selectedRight: Binding.constant(true),
                     difficulty: Binding.constant(Difficulty(maxAttempts: 8, codeSize: 4, numColors: 6, difficulty: "Easy", color: Color.blue)),
                     ran: Binding.constant([2,1,1,1]))
    }
}
