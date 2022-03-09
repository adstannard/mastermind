import SwiftUI

struct GameModeLink: View {
  
    @AppStorage("timed") private var timed = DefaultSettings.timed
    
    @Binding var shouldPopToRootView : Bool
    @Binding var difficulty: Difficulty
    @Binding var ran: [Int]
    
    @State var minutes: [Int] = [3, 4]
    @State var seconds: Int = 0
    @State var showPopUp: Bool = false
    @State var lost: Bool = false
    @State var won: Bool = false
    @State private var action: Int? = 0
    
    @State var gameModeActive : Bool = false
    
    var body: some View {
        
        
        NavigationLink(destination: GameView(shouldPopToRootView: $shouldPopToRootView,
                                             minutes: $minutes[difficulty.difficulty == "Easy" ? 0 : 1],
                                             seconds: $seconds,
                                             showPopUp: $showPopUp,
                                             won: $won,
                                             lost: $lost,
                                             difficulty: $difficulty,
                                             ran: $ran
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
                Button (action: { shouldPopToRootView = false
                            SoundManager.instance.playSound(soundEffect: .tap4)
                        
                } ){
                    Image(systemName: "plus.square")
                }
            }
        }, isActive: self.$gameModeActive){
            ModeButton(difficulty: $difficulty.difficulty,
                       color: $difficulty.color, isActive: $gameModeActive)
        }
    }
}


struct GameModeLink_Previews: PreviewProvider {
    static var previews: some View {
        GameModeLink(shouldPopToRootView: Binding.constant(false),
                     difficulty: Binding.constant(Difficulty(maxAttempts: 8, codeSize: 4, numColors: 6, difficulty: "Easy", color: Color.blue)),
                     ran: Binding.constant([2,1,1,1]))
    }
}
