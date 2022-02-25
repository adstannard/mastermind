import SwiftUI

struct TimerView: View {
    @State var minutes: [Int] = [2, 4]
    @State var seconds: Int = 0
    
    @Binding var lost: Bool
    @Binding var i: Int
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(String(format: "%d:%02d", minutes[i], seconds)).foregroundColor(.accentColor).bold().onReceive(timer) { _ in
            if (minutes[i] > 0) {
                if (seconds > 0) {
                    seconds -= 1
                }
                else {
                    seconds = 59
                    minutes[i] -= 1
                }
            }
            else if (minutes[i] == 0) {
                if (seconds > 0) {
                    seconds -= 1
                }
                else {
                    lost = true
                }
            }
        }
    }
}


struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(lost: Binding.constant(false), i: Binding.constant(1))
    }
}
