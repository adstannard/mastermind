import SwiftUI

struct ColorSelectorItem: View {
    
    @State var color:Color
    @State var canSubmit:Bool = false
    @Binding var content: String
    @Binding var attempt: Int
    @Binding var attemptColors: [[Color]]
    @Binding var attemptNumbers: [[String]]
    @Binding var selected: Int
    @Binding var codeSize: Int
    @Binding var isReadyToSubmit: Bool
    @Binding var showNumbers: Bool
    
    
    var body: some View {
        Button(action: assignColor){
            ColorButton(fill: $color,
                            stroke: Binding.constant(.clear),
                            content: showNumbers ? $content : Binding.constant(""),
                            selected: Binding.constant(false))
        }
    }
    
    
    func setIsReadyToSubmit() {
        
        for i in 0..<codeSize {
            if (attemptColors[attempt][i] == Color.clear){
                canSubmit = false
                return
            }
        }
        canSubmit = true
    }
    
    
    func assignColor() {
        
        // assign color to selected item
        attemptColors[attempt][selected] = color
        
        // assign number to selected item
        attemptNumbers[attempt][selected] = content
        
        // select first possition if last position is reached
        if (selected == (codeSize - 1)){
            selected=0
        }
        // select next position
        else{
            selected+=1
        }
        
        setIsReadyToSubmit()
        
        isReadyToSubmit = canSubmit
        
    }
}


struct ColorSelectorItem_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelectorItem(color: Color.green,
                              content: Binding.constant("A"),
                              attempt: Binding.constant(0),
                              attemptColors: Binding.constant([[Color.green, Color.blue, Color.blue, Color.blue, Color.blue, Color.blue]]),
                              attemptNumbers: Binding.constant([["2", "1", "0", "3", "2", "2"]]),
                              selected: Binding.constant(2),
                              codeSize:Binding.constant(6),
                              isReadyToSubmit:Binding.constant(false),
                              showNumbers: Binding.constant(true)).background(Color.black)
    }
}
