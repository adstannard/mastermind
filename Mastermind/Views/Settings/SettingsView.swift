import SwiftUI

struct SettingsView: View {
    
    private let background = Color(red: 0.0, green: 0.2, blue: 0.2)
    @Binding var sound: Bool
    @Binding var showNumbers: Bool
    @Binding var duplicateColors: Bool
    @Binding var timed: Bool
    @Binding var selectedRight: Bool
    
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(background).ignoresSafeArea()
            VStack(alignment: .leading){
                Group {
                    NavigationLink(destination: InstructionsView(showNumbers: $showNumbers)) {
                        HStack{
                            Text("How to play")
                        }
                    }
                    Divider().background(Color.accentColor).padding(.vertical,10)
                    Toggle(isOn: $sound, label: {Text("Sound:")}).tint(.accentColor)
                    Divider().background(Color.accentColor).padding(.vertical,10)
                    Toggle(isOn: $showNumbers, label: {Text("Show Numbers:")}).tint(.accentColor)
                    Divider().background(Color.accentColor).padding(.vertical,10)
                    Toggle(isOn: $duplicateColors, label: {Text("Allow Repeats:")}).tint(.accentColor)
                    Divider().background(Color.accentColor).padding(.vertical,10)
                    Group {
                        Toggle(isOn: $timed, label: {Text("Use Timer:")}).tint(.accentColor)
                        
                        Divider().background(Color.accentColor).padding(.vertical,10)
                        
                        HStack{
                            Text("Color Selector:")
                            Spacer()
                            Button(action:{ selectedRight.toggle()}){
                                Text(selectedRight ? "Right" : "Left")
                            }
                        }
                    }
                }
                Spacer()
                
            }.foregroundColor(.accentColor)
                .padding()
                .font(.title2)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("")
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Settings").font(.system(size: 30)).foregroundColor(.accentColor)
                        }
                    }
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(sound: Binding.constant(true),
                     showNumbers: Binding.constant(false),
                     duplicateColors: Binding.constant(true),
                     timed: Binding.constant(false),
                     selectedRight: Binding.constant(true))
    }
}
