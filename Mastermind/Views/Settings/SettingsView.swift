import SwiftUI

struct SettingsView: View {
    
    @AppStorage("sound") private var sound = DefaultSettings.sound
    @AppStorage("showNumbers") private var showNumbers = DefaultSettings.showNumbers
    @AppStorage("duplicateColors") private var duplicateColors = DefaultSettings.duplicateColors
    @AppStorage("timed") private var timed = DefaultSettings.timed
    @AppStorage("selectedRight") private var selectedRight = DefaultSettings.selectedRight
    @AppStorage("peek") private var peek = DefaultSettings.peek
    
    var body: some View {
        ZStack {
            // background
            Color.theme.background.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Group {
                    // How to play
                    NavigationLink(destination: InstructionsView()) {
                        HStack {
                            Image(systemName: "questionmark")
                                .resizable()
                                .frame(width: 12, height: 20)
                                .padding(.trailing, 10)
                            Text("How to play")
                        }
                    }
                    Divider().background(Color.accentColor).padding(.vertical, 10)
                    
                    // Sound effects
                    Toggle(isOn: $sound, label: {
                        Image(systemName: "speaker")
                            .resizable()
                            .frame(width: 15, height: 18)
                            .padding(.trailing, 10)
                        Text("Sound:")
                    }).tint(.accentColor)
                    Divider().background(Color.accentColor).padding(.vertical, 10)
                    
                    // Show numbers
                    Toggle(isOn: $showNumbers, label: {
                        Image(systemName: "number").resizable()
                            .frame(width: 20, height: 18)
                            .padding(.trailing, 10)
                        Text("Show Numbers:")
                    }).tint(.accentColor)
                    Divider().background(Color.accentColor).padding(.vertical, 10)
                    
                    // Allow duplicate colors
                    Toggle(isOn: $duplicateColors, label: {
                        Image(systemName: "repeat")
                            .resizable()
                            .frame(width: 20, height: 15)
                            .padding(.trailing, 10)
                        Text("Allow Repeats:")
                    }).tint(.accentColor)
                    Divider().background(Color.accentColor).padding(.vertical, 10)
                    
                    Group {
                        // Use Timer
                        Toggle(isOn: $timed, label: {
                            Image(systemName: "timer")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            Text("Use Timer:")
                        }).tint(.accentColor)
                        Divider().background(Color.accentColor).padding(.vertical, 10)
                        
                        // Peek at secret code
                        Toggle(isOn: $peek, label: {
                            Image(systemName: "eye.trianglebadge.exclamationmark")
                                .resizable()
                                .frame(width: 25, height: 15)
                                .padding(.trailing, 10)
                            Text("Peek at Secret Code:")
                        }).tint(.accentColor)
                        Divider().background(Color.accentColor).padding(.vertical, 10)
                        
                        // Color selector
                        HStack {
                            Image(systemName: "square.filled.and.line.vertical.and.square")
                                .resizable()
                                .frame(width: 20, height: 28)
                                .padding(.trailing, 10)
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
                // screen title
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
        SettingsView().environment(\.locale, Locale(identifier: "en"))
    }
}
