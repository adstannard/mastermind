import SwiftUI

struct PopUpWindow: View {
    @Binding var show: Bool
    @Binding var shouldPopToRootView: Bool
    
    @State private var wave = true
    
    var title: String
    var subTitle: String
    var time: String
    var attempt: String
    
    var body: some View {
        ZStack {
            if show {
                Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: 0) {
                    
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment: .center)
                        .  font(Font.system(size: 19, weight: .semibold))
                        .padding(EdgeInsets(top: 0, leading: 25, bottom: 20, trailing: 25))
                        .foregroundColor(.accentColor)
                    
                    Text(subTitle)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 25, weight: .semibold))
                        .padding(EdgeInsets(top: 0, leading: 25, bottom: 30, trailing: 25))
                        .foregroundColor(.accentColor)
                        .opacity(wave ? 1 : 0.3)
                        .onAppear() {
                            self.wave.toggle()
                            withAnimation(
                                .easeInOut(duration: 1)
                                    .repeatForever(autoreverses: true)
                                    .speed(2))
                            {
                                self.wave.toggle()
                            }
                        }
                    
                    HStack {
                        if (time != "") {
                            Text(time)
                                .multilineTextAlignment(.center)
                                .font(Font.system(size: 16))
                                .padding(EdgeInsets(top: 0, leading: 25, bottom: 10, trailing: 25))
                                .foregroundColor(.accentColor)
                        }
                        
                        Text(attempt)
                            .multilineTextAlignment(.center)
                            .font(Font.system(size: 16))
                            .padding(EdgeInsets(top: 0, leading: 25, bottom: 10, trailing: 25))
                            .foregroundColor(.accentColor)
                    }
                    
                    Button(action: {
                        withAnimation(.linear(duration: 0.3)) {
                            show = false
                        }
                        shouldPopToRootView = false
                        
                    }, label: {
                        Text("OK")
                            .frame(maxWidth: 60)
                            .frame(height: 40, alignment: .center)
                            .foregroundColor(.accentColor)
                            .font(Font.system(size: 23, weight: .semibold))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.accentColor, lineWidth: 2)
                            ).background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 0.0, green: 0.15, blue: 0.15))).padding(EdgeInsets(top: 30, leading: 25, bottom: 20, trailing: 25))
                        
                    }).buttonStyle(PlainButtonStyle())
                }
                .frame(maxWidth: 242)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.accentColor, lineWidth: 2)
                ).background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 0.0, green: 0.2, blue: 0.2)))
            }
        }
    }
}


struct PopUpWindow_Previews: PreviewProvider {
    static var previews: some View {
        PopUpWindow(show: Binding.constant(true),
                    shouldPopToRootView: Binding.constant(true),
                    title:"CONGRATULATIONS!",
                    // title:"Congratulations!",
                    subTitle: "YOU WIN",
                    time:"time left\n0:30",
                    attempt:"attempts\n2")
    }
}
