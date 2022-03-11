import SwiftUI

struct ColorSelectorView: View {
    
    @Binding var numColors: Int
    @Binding var attempt: Int
    @Binding var attemptColors: [[Color]]
    @Binding var selected: Int
    @Binding var codeSize: Int
    @Binding var isReadyToSubmit:Bool
    @Binding var attemptNumbers: [[String]]
    
    @AppStorage("showNumbers") private var showNumbers = DefaultSettings.showNumbers
    
    var body: some View {
        HStack{
            ZStack{
                // color selector border
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.accentColor, lineWidth: 2)
                    .frame(width: 44, height: CGFloat(numColors)*46)
                
                // color selector items
                VStack {
                    ForEach(0..<numColors) {
                        ColorSelectorItem(color: Constants.colors[$0],
                                          content: Binding.constant(String($0+1)),
                                          attempt:$attempt,
                                          attemptColors:$attemptColors,
                                          attemptNumbers: $attemptNumbers,
                                          selected: $selected,
                                          codeSize: $codeSize,
                                          isReadyToSubmit:$isReadyToSubmit,
                                          showNumbers: $showNumbers
                        ).padding(.all, 5)
                    }
                }
            }.padding(.top, 2) // avoid cropped top in scrollview
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
                          attemptNumbers: Binding.constant([["0", "3", "2", "2"]]))
        
    }
}
