import SwiftUI


struct FeedbackItem: View {
    
    var color: Color
    var feedbackType: Int
    
    @State private var opacity: Double = 1
    @State private var white = Color.white

    
    var body: some View{
        switch feedbackType{
        case 1:
            Circle()
                .frame(width: 6, height: 6)
                .foregroundColor(color)
                .padding(6)
        case 2:
            ZStack{
                Capsule()
                    .frame(width: 7, height: 2)
                    .rotationEffect(Angle(degrees: 45))
                Capsule()
                    .frame(width: 7, height: 2)
                    .rotationEffect(Angle(degrees: -45))
            }
            .foregroundColor(color)
            .padding(EdgeInsets(top: 8, leading: 5.5, bottom: 8, trailing: 5.5))
        case 3:
            Capsule()
                .frame(width: 5, height: 2)
                .foregroundColor(color)
                .padding(EdgeInsets(top: 8, leading: 6.5, bottom: 8, trailing: 6.5))
        default:
            Circle()
                .frame(width: 6, height: 6)
                .foregroundColor(color)
                .padding(6)
        }
    }
}

struct FeedbackItem_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackItem(color: .green, feedbackType: 4).background(.black)
    }
}
