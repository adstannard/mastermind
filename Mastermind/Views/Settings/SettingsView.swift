import SwiftUI

struct SettingsView: View {
    
    private let background = Color(red: 0.0, green: 0.2, blue: 0.2)
    
    
    @AppStorage("sound") private var sound = DefaultSettings.sound
    @AppStorage("showNumbers") private var showNumbers = DefaultSettings.showNumbers
    @AppStorage("duplicateColors") private var duplicateColors = DefaultSettings.duplicateColors
    @AppStorage("timed") private var timed = DefaultSettings.timed
    @AppStorage("selectedRight") private var selectedRight = DefaultSettings.selectedRight
    
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(background).ignoresSafeArea()
            VStack(alignment: .leading) {
                Group {
                    NavigationLink(destination: InstructionsView()) {
                        HStack {
                            Text("How to play")
                        }
                    }
                    Divider().background(Color.accentColor).padding(.vertical,10)
                    Toggle(isOn: $sound, label: { Text("Sound:") }).tint(.accentColor)
                    Divider().background(Color.accentColor).padding(.vertical,10)
                    Toggle(isOn: $showNumbers, label: { Text("Show Numbers:") }).tint(.accentColor)
                    Divider().background(Color.accentColor).padding(.vertical,10)
                    Toggle(isOn: $duplicateColors, label: { Text("Allow Repeats:") }).tint(.accentColor)
                    Divider().background(Color.accentColor).padding(.vertical,10)
                    Group {
                        Toggle(isOn: $timed, label: { Text("Use Timer:") }).tint(.accentColor)
                        
                        Divider().background(Color.accentColor).padding(.vertical,10)
                        
                        HStack {
                            Text("Color Selector:")
                            Spacer()
                            Button(action:{ selectedRight.toggle() }) {
                                Text(selectedRight ? "Right" : "Left")
                            }
                        }
                    }
                }
                Spacer()
            }
            .foregroundColor(.accentColor)
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
        SettingsView().environment(\.locale, Locale(identifier: "es"))
    }
}
