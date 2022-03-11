import SwiftUI


struct FeedbackItem: View {
    
    var color: Color
    var feedbackType: Int
    
    
    var body: some View {
        switch feedbackType {
            
        // ciclular feedback item
        case 1:
            Circle()
                .frame(width: 6, height: 6)
                .foregroundColor(color)
                .padding(6)
            
        // cruciform feedback item
        case 2:
            Cross(color: color)
            
        // dash feedback item
        case 3:
            Capsule()
                .frame(width: 5, height: 2)
                .foregroundColor(color)
                .padding(EdgeInsets(top: 8, leading: 6.5, bottom: 8, trailing: 6.5))
            
        // ciclular feedback item (default)
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

// Custom cross view
struct Cross: View {
    
    let color: Color
    
    var body: some View {
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
    }
}
