import Foundation
import SwiftUI


extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let secondaryAccent = Color("SecondaryAccentColor")
    let background = Color("BackgroundColor")
    let secondaryBackground = Color("SecondaryBackgroundColor")
    let gray = Color("GrayColor")
    let green = Color("GreenColor")
    let orange = Color("OrangeColor")
    let red = Color("RedColor")
    let yellow = Color("YellowColor")
}
