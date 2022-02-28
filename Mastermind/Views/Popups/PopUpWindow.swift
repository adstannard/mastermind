import SwiftUI

struct PopUpWindow: View {
    @Binding var show: Bool
    
    var title: String
    var message: String
    
    var body: some View {
        ZStack {
            if show {
                Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: 0) {
                    
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment: .center)
                        .font(Font.system(size: 23, weight: .semibold))
                        .foregroundColor(.accentColor)
                    
                    Text(message)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 16, weight: .semibold))
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                        .foregroundColor(.accentColor)
                    
                    Button(action: {
                        withAnimation(.linear(duration: 0.3)) {
                            show = false
                        }
                    }, label: {
                        Text("OK")
                            .frame(maxWidth: 60)
                            .frame(height: 40, alignment: .center)
                            .foregroundColor(.accentColor)
                            .font(Font.system(size: 23, weight: .semibold))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.accentColor, lineWidth: 2)
                            ).background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 0.0, green: 0.15, blue: 0.15))).padding()
                        
                    }).buttonStyle(PlainButtonStyle())
                }
                .frame(maxWidth: 200)
                
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
        PopUpWindow(show: Binding.constant(true),  title:"You Win!", message:"Time left\n 0:30")
    }
}
