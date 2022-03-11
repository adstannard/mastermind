import SwiftUI

struct AttemptView: View {
    
    @Binding var selected: Int
    @Binding var attempt: Int
    @Binding var currentAttempt: Int
    @Binding var feedback: [[Color]]
    @Binding var codeSize: Int
    @Binding var attemptColors: [[Color]]
    @Binding var attemptNumbers: [[String]]
    
    @AppStorage("showNumbers") private var showNumbers = DefaultSettings.showNumbers
    
    var body: some View {
        HStack{
            // attempt number
            Text(String(attempt+1))
                .font(.system(size: 20, weight: .semibold, design: .default))
                .foregroundColor(currentAttempt == attempt ? .accentColor : currentAttempt > attempt ? Color.theme.secondaryAccent : Color.gray)
                .frame(alignment: .topLeading)
            
            // attempt items
            ForEach(0..<codeSize) {
                Spacer().frame(maxWidth: CGFloat(70/codeSize))
                AttemptItem(
                    selected:$selected,
                    attempt: $attempt,
                    position: Binding.constant($0),
                    currentAttempt: $currentAttempt,
                    color: $attemptColors[attempt][$0],
                    content: showNumbers ? $attemptNumbers[attempt][$0] : Binding.constant(""))
            }
            // attempt feedback
            FeedbackView(feedback: $feedback,
                         codeSize:$codeSize,
                         attempt: $attempt,
                         showNumbers: $showNumbers)
        }
        .padding(0.0)
    }
}

struct AttemptView_Previews: PreviewProvider {
    static var previews: some View {
        AttemptView(selected: Binding.constant(0),
                    attempt: Binding.constant(0),
                    currentAttempt: Binding.constant(0),
                    feedback:Binding.constant([[Color.red,Color.red,Color.white,Color.gray,Color.gray,Color.gray]]),
                    codeSize:Binding.constant(6),
                    attemptColors: Binding.constant([[.blue,.red,.blue,.white,.green,.green]]),
                    attemptNumbers: Binding.constant([["2","3","2","4","1","1"]]))
    }
}

