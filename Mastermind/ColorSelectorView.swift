import SwiftUI

struct ColorSelectorView: View {
    
    private let colors = [Color.red, Color.orange, Color.blue, Color.green, Color.yellow, Color.purple, Color.mint, Color.white]
    @Binding var numColors: Int
    @Binding var attempt: Int
    @Binding var attemptColors: [[Color]]
    @Binding var selected: Int
    @Binding var codeSize: Int
    @Binding var isReadyToSubmit:Bool
    @Binding var showNumbers: Bool
    @Binding var attemptNumbers: [[String]]
    
    var body: some View {
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.accentColor, lineWidth: 2)
                    .frame(width: 44, height: CGFloat(numColors)*46)
                
                VStack {
                    ForEach(0..<numColors) {
                        ColorSelectorItemView(color: colors[$0],
                                              content: Binding.constant(String($0+1)),
                                              attempt:$attempt,
                                              attemptColors:$attemptColors,
                                              attemptNumbers: $attemptNumbers,
                                              selected: $selected,
                                              codeSize: $codeSize,
                                              isReadyToSubmit:$isReadyToSubmit,
                                              showNumbers: $showNumbers
                        )
                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.2))
                            .padding(.all, 5)
                    }
                }
            }
        }
    }
}

struct ColorSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelectorView(numColors: Binding.constant(8),
                          attempt:Binding.constant(0),
                          attemptColors:Binding.constant([[Color.red,Color.blue,Color.green,Color.clear]]),
                          selected:Binding.constant(2),
                          codeSize: Binding.constant(4),
                          isReadyToSubmit:Binding.constant(false),
                          showNumbers: Binding.constant(true),
                          attemptNumbers: Binding.constant([["0", "3", "2", "2"]]))
        
    }
}
