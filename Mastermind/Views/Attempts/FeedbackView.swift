import SwiftUI

struct FeedbackView: View {
    
    @Binding var feedback: [[Color]]
    @Binding var codeSize: Int
    @Binding var attempt: Int
    @Binding var showNumbers: Bool
    
    var body: some View {
        // four feedback items
        if (codeSize == 4) {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom), content: {
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top), content: {
                            Rectangle()
                                .foregroundColor(Color.clear)
                                .frame(width: 30, height: 30)
                            getFeedbackItem(position: 0)
                        })
                        getFeedbackItem(position: 3)
                    })
                    getFeedbackItem(position: 1)
                })
                getFeedbackItem(position: 2)
            })
        }
        // five feedback items
        if (codeSize == 5){
            ZStack {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom), content: {
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top), content: {
                                Rectangle()
                                    .foregroundColor(Color.clear)
                                    .frame(width: 30, height: 32)
                                getFeedbackItem(position: 0)
                            })
                            getFeedbackItem(position: 4)
                        })
                        getFeedbackItem(position: 1)
                    })
                    getFeedbackItem(position: 3)
                })
                getFeedbackItem(position: 2)
            }
        }
        // six feedback items
        if (codeSize == 6) {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center), content: {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom), content: {
                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top), content: {
                                    Rectangle()
                                        .foregroundColor(Color.clear)
                                        .frame(width: 30, height: 35)
                                    getFeedbackItem(position: 0)
                                })
                                getFeedbackItem(position: 5)
                            })
                            getFeedbackItem(position: 1)
                        })
                        getFeedbackItem(position: 4)
                    })
                    getFeedbackItem(position: 2)
                })
                getFeedbackItem(position: 3)
            })
        }
    }
    
    
    // Gets feedback item
    func getFeedbackItem (position: Int) -> FeedbackItem {
        
        let color = feedback[attempt][position]
        var type: Int
        
        if (showNumbers) {
            switch color {
            case Color.red :
                type = 1
            case Color.white :
                type = 2
            case Color.gray :
                type = 3
            default:
                type = 1
            }
        }
        else {
            type = 1
        }
        return FeedbackItem(color: color, feedbackType: type)
    }
}



struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView(feedback:Binding.constant([[Color.red, Color.red, Color.red, Color.white, Color.white, Color.gray]]),
                     codeSize: Binding.constant(6),
                     attempt: Binding.constant(0),
                     showNumbers: Binding.constant(true)).background(.black)
    }
}
