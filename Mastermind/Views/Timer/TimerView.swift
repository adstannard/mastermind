import SwiftUI

struct TimerView: View {
    
    @Binding var minutes: [Int]
    @Binding var seconds: Int
    @Binding var i: Int
    @Binding var showPopUp: Bool
    @Binding var lost: Bool
    @Binding var won: Bool
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(String(format: "%d:%02d", minutes[i], seconds))
            .foregroundColor(.accentColor)
            .bold()
            .onReceive(timer)
        { _ in
            
            if (!lost){
                // stop timer
                if (won) {
                    timer.upstream.connect().cancel()
                }
                else if (minutes[i] > 0 || seconds > 0) {
                    // deduct a second
                    if (seconds > 0) {
                        seconds -= 1
                    }
                    // deduct a minute and reset seconds to 59
                    else {
                        seconds = 59
                        minutes[i] -= 1
                    }
                }
                // no time left (stop timer, show popup, play lose sound)
                else  {
                    lost = true
                    timer.upstream.connect().cancel()
                    SoundManager.instance.playSound(soundEffect: .lose)
                    showPopUp = true
                }
            }
            else {
                return
            }
        }
    }
}


struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(minutes:Binding.constant([1, 4]),
                  seconds: Binding.constant(0),
                  i: Binding.constant(0),
                  showPopUp: Binding.constant(false),
                  lost: Binding.constant(false),
                  won: Binding.constant(false))
    }
}
