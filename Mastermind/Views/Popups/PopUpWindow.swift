import SwiftUI

struct PopUpWindow: View {
    @Binding var show: Bool
    @Binding var shouldPopToRootView: Bool
    
    @State private var fadeInOut = true
    
    var title: String
    var subTitle: String
    var time: String
    var attempt: Int
    
    var body: some View {
        ZStack {
            if show {
                // darken background
                Color.black.opacity(show ? 0.4 : 0).edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: 0) {
                    // popup title
                    Text(LocalizedStringKey(title))
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment: .center)
                        .font(Font.system(size: 23, weight: .semibold))
                        .padding(EdgeInsets(top: 0, leading: 25, bottom: 10, trailing: 25))
                        .foregroundColor(.accentColor)
                    
                    // popup subtitle (with fade in/fade out animation)
                    Text(LocalizedStringKey(subTitle))
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 25, weight: .semibold))
                        .padding(EdgeInsets(top: 0, leading: 25, bottom: 20, trailing: 25))
                        .foregroundColor(.accentColor)
                        .opacity(fadeInOut ? 1 : 0.3)
                        .onAppear() {
                            self.fadeInOut.toggle()
                            withAnimation(
                                .easeInOut(duration: 1)
                                    .repeatForever(autoreverses: true)
                                    .speed(2))
                            {
                                self.fadeInOut.toggle()
                            }
                        }
                    
                    // game info
                    HStack {
                        // time left
                        if (time != "") {
                            VStack{
                                Text("time left")
                                    .multilineTextAlignment(.center)
                                    .font(Font.system(size: 16))
                                    .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
                                    .foregroundColor(.accentColor)
                                Text(time)
                                    .multilineTextAlignment(.center)
                                    .font(Font.system(size: 16))
                                    .padding(EdgeInsets(top: 0, leading: 25, bottom: 10, trailing: 25))
                                    .foregroundColor(.accentColor)
                            }
                        }
                        // attempts used
                        VStack{
                            Text("attempt\(attempt <= 1 ? "" : "s")")
                                .multilineTextAlignment(.center)
                                .font(Font.system(size: 16))
                                .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
                                .foregroundColor(.accentColor)
                            Text(String(attempt))
                                .multilineTextAlignment(.center)
                                .font(Font.system(size: 16))
                                .padding(EdgeInsets(top: 0, leading: 25, bottom: 10, trailing: 25))
                                .foregroundColor(.accentColor)
                        }
                    }
                    
                    // OK button
                    Button(action: {
                        // play tap sound
                        SoundManager.instance.playSound(soundEffect: .tap5)
                        
                        // dismiss popup
                        withAnimation(.linear(duration: 0.3)) {
                            show = false
                        }
                        // go back to root (home screen)
                        shouldPopToRootView = false
                        
                    }, label: {
                        Text("OK")
                            .frame(maxWidth: 60)
                            .frame(height: 40, alignment: .center)
                            .foregroundColor(
                                Color.accentColor
                            )
                            .font(Font.system(size: 23, weight: .semibold))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.accentColor, lineWidth: 2)
                            ).background(RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.theme.secondaryBackground))
                            .padding(EdgeInsets(top: 10, leading: 25, bottom: 20, trailing: 25))
                        
                    }).buttonStyle(PlainButtonStyle())
                }
                .frame(maxWidth: 281)
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.accentColor, lineWidth: 2))
                .background(RoundedRectangle(cornerRadius: 10)
                                .fill(Color.theme.background))
            }
        }
    }
}


struct PopUpWindow_Previews: PreviewProvider {
    static var previews: some View {
        PopUpWindow(show: Binding.constant(true),
                    shouldPopToRootView: Binding.constant(true),
                    title: "TitleWon",
                    subTitle: "SubTitleWon",
                    time:  String(format: "%d:%02d", 3, 2),
                    attempt: 3)
            .environment(\.locale, Locale(identifier: "en"))
    }
}
