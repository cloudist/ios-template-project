//
//  UIColor+Msic.swift
//  Extensions
//
//  Created by liubo on 2018/8/16.
//

import UIKit

#if canImport(UIKit)
import UIKit
/// Color
public typealias Color = UIColor
#endif

#if canImport(Cocoa)
import Cocoa
/// Color
public typealias Color = NSColor
#endif

public extension Color {
    
    public convenience init?(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }
        
        var alpha = alpha
        if alpha < 0 { alpha = 0 }
        if alpha > 1 { alpha = 1 }
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    public convenience init?(hex: Int, alpha: CGFloat = 1) {
        var alpha = alpha
        if alpha < 0 { alpha = 0 }
        if alpha > 1 { alpha = 1 }
        
        let red = (hex >> 16) & 0xff
        let green = (hex >> 8) & 0xff
        let blue = hex & 0xff
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public convenience init?(hexString: String, alpha: CGFloat = 1) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }
        
        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }
        
        guard let hexValue = Int(string, radix: 16) else { return nil }
        
        var alpha = alpha
        if alpha < 0 { alpha = 0 }
        if alpha > 1 { alpha = 1 }
        
        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

public extension Color {
    
    /// SwifterSwift: Google Material design colors palette.
    public struct Material {
        // https://material.google.com/style/color.html
        /// SwifterSwift: color red500
        public static let red                    = red500
        
        /// SwifterSwift: hex #FFEBEE
        public static let red50                    = Color(hex: 0xFFEBEE)!
        
        /// SwifterSwift: hex #FFCDD2
        public static let red100                = Color(hex: 0xFFCDD2)!
        
        /// SwifterSwift: hex #EF9A9A
        public static let red200                = Color(hex: 0xEF9A9A)!
        
        /// SwifterSwift: hex #E57373
        public static let red300                = Color(hex: 0xE57373)!
        
        /// SwifterSwift: hex #EF5350
        public static let red400                = Color(hex: 0xEF5350)!
        
        /// SwifterSwift: hex #F44336
        public static let red500                = Color(hex: 0xF44336)!
        
        /// SwifterSwift: hex #E53935
        public static let red600                = Color(hex: 0xE53935)!
        
        /// SwifterSwift: hex #D32F2F
        public static let red700                = Color(hex: 0xD32F2F)!
        
        /// SwifterSwift: hex #C62828
        public static let red800                = Color(hex: 0xC62828)!
        
        /// SwifterSwift: hex #B71C1C
        public static let red900                = Color(hex: 0xB71C1C)!
        
        /// SwifterSwift: hex #FF8A80
        public static let redA100                = Color(hex: 0xFF8A80)!
        
        /// SwifterSwift: hex #FF5252
        public static let redA200                = Color(hex: 0xFF5252)!
        
        /// SwifterSwift: hex #FF1744
        public static let redA400                = Color(hex: 0xFF1744)!
        
        /// SwifterSwift: hex #D50000
        public static let redA700                = Color(hex: 0xD50000)!
        
        /// SwifterSwift: color pink500
        public static let pink                    = pink500
        
        /// SwifterSwift: hex #FCE4EC
        public static let pink50                = Color(hex: 0xFCE4EC)!
        
        /// SwifterSwift: hex #F8BBD0
        public static let pink100                = Color(hex: 0xF8BBD0)!
        
        /// SwifterSwift: hex #F48FB1
        public static let pink200                = Color(hex: 0xF48FB1)!
        
        /// SwifterSwift: hex #F06292
        public static let pink300                = Color(hex: 0xF06292)!
        
        /// SwifterSwift: hex #EC407A
        public static let pink400                = Color(hex: 0xEC407A)!
        
        /// SwifterSwift: hex #E91E63
        public static let pink500                = Color(hex: 0xE91E63)!
        
        /// SwifterSwift: hex #D81B60
        public static let pink600                = Color(hex: 0xD81B60)!
        
        /// SwifterSwift: hex #C2185B
        public static let pink700                = Color(hex: 0xC2185B)!
        
        /// SwifterSwift: hex #AD1457
        public static let pink800                = Color(hex: 0xAD1457)!
        
        /// SwifterSwift: hex #880E4F
        public static let pink900                = Color(hex: 0x880E4F)!
        
        /// SwifterSwift: hex #FF80AB
        public static let pinkA100                = Color(hex: 0xFF80AB)!
        
        /// SwifterSwift: hex #FF4081
        public static let pinkA200                = Color(hex: 0xFF4081)!
        
        /// SwifterSwift: hex #F50057
        public static let pinkA400                = Color(hex: 0xF50057)!
        
        /// SwifterSwift: hex #C51162
        public static let pinkA700                = Color(hex: 0xC51162)!
        
        /// SwifterSwift: color purple500
        public static let purple                = purple500
        
        /// SwifterSwift: hex #F3E5F5
        public static let purple50                = Color(hex: 0xF3E5F5)!
        
        /// SwifterSwift: hex #E1BEE7
        public static let purple100                = Color(hex: 0xE1BEE7)!
        
        /// SwifterSwift: hex #CE93D8
        public static let purple200                = Color(hex: 0xCE93D8)!
        
        /// SwifterSwift: hex #BA68C8
        public static let purple300                = Color(hex: 0xBA68C8)!
        
        /// SwifterSwift: hex #AB47BC
        public static let purple400                = Color(hex: 0xAB47BC)!
        
        /// SwifterSwift: hex #9C27B0
        public static let purple500                = Color(hex: 0x9C27B0)!
        
        /// SwifterSwift: hex #8E24AA
        public static let purple600                = Color(hex: 0x8E24AA)!
        
        /// SwifterSwift: hex #7B1FA2
        public static let purple700                = Color(hex: 0x7B1FA2)!
        
        /// SwifterSwift: hex #6A1B9A
        public static let purple800                = Color(hex: 0x6A1B9A)!
        
        /// SwifterSwift: hex #4A148C
        public static let purple900                = Color(hex: 0x4A148C)!
        
        /// SwifterSwift: hex #EA80FC
        public static let purpleA100            = Color(hex: 0xEA80FC)!
        
        /// SwifterSwift: hex #E040FB
        public static let purpleA200            = Color(hex: 0xE040FB)!
        
        /// SwifterSwift: hex #D500F9
        public static let purpleA400            = Color(hex: 0xD500F9)!
        
        /// SwifterSwift: hex #AA00FF
        public static let purpleA700            = Color(hex: 0xAA00FF)!
        
        /// SwifterSwift: color deepPurple500
        public static let deepPurple            = deepPurple500
        
        /// SwifterSwift: hex #EDE7F6
        public static let deepPurple50            = Color(hex: 0xEDE7F6)!
        
        /// SwifterSwift: hex #D1C4E9
        public static let deepPurple100            = Color(hex: 0xD1C4E9)!
        
        /// SwifterSwift: hex #B39DDB
        public static let deepPurple200            = Color(hex: 0xB39DDB)!
        
        /// SwifterSwift: hex #9575CD
        public static let deepPurple300            = Color(hex: 0x9575CD)!
        
        /// SwifterSwift: hex #7E57C2
        public static let deepPurple400            = Color(hex: 0x7E57C2)!
        
        /// SwifterSwift: hex #673AB7
        public static let deepPurple500            = Color(hex: 0x673AB7)!
        
        /// SwifterSwift: hex #5E35B1
        public static let deepPurple600            = Color(hex: 0x5E35B1)!
        
        /// SwifterSwift: hex #512DA8
        public static let deepPurple700            = Color(hex: 0x512DA8)!
        
        /// SwifterSwift: hex #4527A0
        public static let deepPurple800            = Color(hex: 0x4527A0)!
        
        /// SwifterSwift: hex #311B92
        public static let deepPurple900            = Color(hex: 0x311B92)!
        
        /// SwifterSwift: hex #B388FF
        public static let deepPurpleA100        = Color(hex: 0xB388FF)!
        
        /// SwifterSwift: hex #7C4DFF
        public static let deepPurpleA200        = Color(hex: 0x7C4DFF)!
        
        /// SwifterSwift: hex #651FFF
        public static let deepPurpleA400        = Color(hex: 0x651FFF)!
        
        /// SwifterSwift: hex #6200EA
        public static let deepPurpleA700        = Color(hex: 0x6200EA)!
        
        /// SwifterSwift: color indigo500
        public static let indigo                = indigo500
        
        /// SwifterSwift: hex #E8EAF6
        public static let indigo50                = Color(hex: 0xE8EAF6)!
        
        /// SwifterSwift: hex #C5CAE9
        public static let indigo100                = Color(hex: 0xC5CAE9)!
        
        /// SwifterSwift: hex #9FA8DA
        public static let indigo200                = Color(hex: 0x9FA8DA)!
        
        /// SwifterSwift: hex #7986CB
        public static let indigo300                = Color(hex: 0x7986CB)!
        
        /// SwifterSwift: hex #5C6BC0
        public static let indigo400                = Color(hex: 0x5C6BC0)!
        
        /// SwifterSwift: hex #3F51B5
        public static let indigo500                = Color(hex: 0x3F51B5)!
        
        /// SwifterSwift: hex #3949AB
        public static let indigo600                = Color(hex: 0x3949AB)!
        
        /// SwifterSwift: hex #303F9F
        public static let indigo700                = Color(hex: 0x303F9F)!
        
        /// SwifterSwift: hex #283593
        public static let indigo800                = Color(hex: 0x283593)!
        
        /// SwifterSwift: hex #1A237E
        public static let indigo900                = Color(hex: 0x1A237E)!
        
        /// SwifterSwift: hex #8C9EFF
        public static let indigoA100            = Color(hex: 0x8C9EFF)!
        
        /// SwifterSwift: hex #536DFE
        public static let indigoA200            = Color(hex: 0x536DFE)!
        
        /// SwifterSwift: hex #3D5AFE
        public static let indigoA400            = Color(hex: 0x3D5AFE)!
        
        /// SwifterSwift: hex #304FFE
        public static let indigoA700            = Color(hex: 0x304FFE)!
        
        /// SwifterSwift: color blue500
        public static let blue                    = blue500
        
        /// SwifterSwift: hex #E3F2FD
        public static let blue50                = Color(hex: 0xE3F2FD)!
        
        /// SwifterSwift: hex #BBDEFB
        public static let blue100                = Color(hex: 0xBBDEFB)!
        
        /// SwifterSwift: hex #90CAF9
        public static let blue200                = Color(hex: 0x90CAF9)!
        
        /// SwifterSwift: hex #64B5F6
        public static let blue300                = Color(hex: 0x64B5F6)!
        
        /// SwifterSwift: hex #42A5F5
        public static let blue400                = Color(hex: 0x42A5F5)!
        
        /// SwifterSwift: hex #2196F3
        public static let blue500                = Color(hex: 0x2196F3)!
        
        /// SwifterSwift: hex #1E88E5
        public static let blue600                = Color(hex: 0x1E88E5)!
        
        /// SwifterSwift: hex #1976D2
        public static let blue700                = Color(hex: 0x1976D2)!
        
        /// SwifterSwift: hex #1565C0
        public static let blue800                = Color(hex: 0x1565C0)!
        
        /// SwifterSwift: hex #0D47A1
        public static let blue900                = Color(hex: 0x0D47A1)!
        
        /// SwifterSwift: hex #82B1FF
        public static let blueA100                = Color(hex: 0x82B1FF)!
        
        /// SwifterSwift: hex #448AFF
        public static let blueA200                = Color(hex: 0x448AFF)!
        
        /// SwifterSwift: hex #2979FF
        public static let blueA400                = Color(hex: 0x2979FF)!
        
        /// SwifterSwift: hex #2962FF
        public static let blueA700                = Color(hex: 0x2962FF)!
        
        /// SwifterSwift: color lightBlue500
        public static let lightBlue                = lightBlue500
        
        /// SwifterSwift: hex #E1F5FE
        public static let lightBlue50            = Color(hex: 0xE1F5FE)!
        
        /// SwifterSwift: hex #B3E5FC
        public static let lightBlue100            = Color(hex: 0xB3E5FC)!
        
        /// SwifterSwift: hex #81D4FA
        public static let lightBlue200            = Color(hex: 0x81D4FA)!
        
        /// SwifterSwift: hex #4FC3F7
        public static let lightBlue300            = Color(hex: 0x4FC3F7)!
        
        /// SwifterSwift: hex #29B6F6
        public static let lightBlue400            = Color(hex: 0x29B6F6)!
        
        /// SwifterSwift: hex #03A9F4
        public static let lightBlue500            = Color(hex: 0x03A9F4)!
        
        /// SwifterSwift: hex #039BE5
        public static let lightBlue600            = Color(hex: 0x039BE5)!
        
        /// SwifterSwift: hex #0288D1
        public static let lightBlue700            = Color(hex: 0x0288D1)!
        
        /// SwifterSwift: hex #0277BD
        public static let lightBlue800            = Color(hex: 0x0277BD)!
        
        /// SwifterSwift: hex #01579B
        public static let lightBlue900            = Color(hex: 0x01579B)!
        
        /// SwifterSwift: hex #80D8FF
        public static let lightBlueA100            = Color(hex: 0x80D8FF)!
        
        /// SwifterSwift: hex #40C4FF
        public static let lightBlueA200            = Color(hex: 0x40C4FF)!
        
        /// SwifterSwift: hex #00B0FF
        public static let lightBlueA400            = Color(hex: 0x00B0FF)!
        
        /// SwifterSwift: hex #0091EA
        public static let lightBlueA700            = Color(hex: 0x0091EA)!
        
        /// SwifterSwift: color cyan500
        public static let cyan                    = cyan500
        
        /// SwifterSwift: hex #E0F7FA
        public static let cyan50                = Color(hex: 0xE0F7FA)!
        
        /// SwifterSwift: hex #B2EBF2
        public static let cyan100                = Color(hex: 0xB2EBF2)!
        
        /// SwifterSwift: hex #80DEEA
        public static let cyan200                = Color(hex: 0x80DEEA)!
        
        /// SwifterSwift: hex #4DD0E1
        public static let cyan300                = Color(hex: 0x4DD0E1)!
        
        /// SwifterSwift: hex #26C6DA
        public static let cyan400                = Color(hex: 0x26C6DA)!
        
        /// SwifterSwift: hex #00BCD4
        public static let cyan500                = Color(hex: 0x00BCD4)!
        
        /// SwifterSwift: hex #00ACC1
        public static let cyan600                = Color(hex: 0x00ACC1)!
        
        /// SwifterSwift: hex #0097A7
        public static let cyan700                = Color(hex: 0x0097A7)!
        
        /// SwifterSwift: hex #00838F
        public static let cyan800                = Color(hex: 0x00838F)!
        
        /// SwifterSwift: hex #006064
        public static let cyan900                = Color(hex: 0x006064)!
        
        /// SwifterSwift: hex #84FFFF
        public static let cyanA100                = Color(hex: 0x84FFFF)!
        
        /// SwifterSwift: hex #18FFFF
        public static let cyanA200                = Color(hex: 0x18FFFF)!
        
        /// SwifterSwift: hex #00E5FF
        public static let cyanA400                = Color(hex: 0x00E5FF)!
        
        /// SwifterSwift: hex #00B8D4
        public static let cyanA700                = Color(hex: 0x00B8D4)!
        
        /// SwifterSwift: color teal500
        public static let teal                    = teal500
        
        /// SwifterSwift: hex #E0F2F1
        public static let teal50                = Color(hex: 0xE0F2F1)!
        
        /// SwifterSwift: hex #B2DFDB
        public static let teal100                = Color(hex: 0xB2DFDB)!
        
        /// SwifterSwift: hex #80CBC4
        public static let teal200                = Color(hex: 0x80CBC4)!
        
        /// SwifterSwift: hex #4DB6AC
        public static let teal300                = Color(hex: 0x4DB6AC)!
        
        /// SwifterSwift: hex #26A69A
        public static let teal400                = Color(hex: 0x26A69A)!
        
        /// SwifterSwift: hex #009688
        public static let teal500                = Color(hex: 0x009688)!
        
        /// SwifterSwift: hex #00897B
        public static let teal600                = Color(hex: 0x00897B)!
        
        /// SwifterSwift: hex #00796B
        public static let teal700                = Color(hex: 0x00796B)!
        
        /// SwifterSwift: hex #00695C
        public static let teal800                = Color(hex: 0x00695C)!
        
        /// SwifterSwift: hex #004D40
        public static let teal900                = Color(hex: 0x004D40)!
        
        /// SwifterSwift: hex #A7FFEB
        public static let tealA100                = Color(hex: 0xA7FFEB)!
        
        /// SwifterSwift: hex #64FFDA
        public static let tealA200                = Color(hex: 0x64FFDA)!
        
        /// SwifterSwift: hex #1DE9B6
        public static let tealA400                = Color(hex: 0x1DE9B6)!
        
        /// SwifterSwift: hex #00BFA5
        public static let tealA700                = Color(hex: 0x00BFA5)!
        
        /// SwifterSwift: color green500
        public static let green                    = green500
        
        /// SwifterSwift: hex #E8F5E9
        public static let green50                = Color(hex: 0xE8F5E9)!
        
        /// SwifterSwift: hex #C8E6C9
        public static let green100                = Color(hex: 0xC8E6C9)!
        
        /// SwifterSwift: hex #A5D6A7
        public static let green200                = Color(hex: 0xA5D6A7)!
        
        /// SwifterSwift: hex #81C784
        public static let green300                = Color(hex: 0x81C784)!
        
        /// SwifterSwift: hex #66BB6A
        public static let green400                = Color(hex: 0x66BB6A)!
        
        /// SwifterSwift: hex #4CAF50
        public static let green500                = Color(hex: 0x4CAF50)!
        
        /// SwifterSwift: hex #43A047
        public static let green600                = Color(hex: 0x43A047)!
        
        /// SwifterSwift: hex #388E3C
        public static let green700                = Color(hex: 0x388E3C)!
        
        /// SwifterSwift: hex #2E7D32
        public static let green800                = Color(hex: 0x2E7D32)!
        
        /// SwifterSwift: hex #1B5E20
        public static let green900                = Color(hex: 0x1B5E20)!
        
        /// SwifterSwift: hex #B9F6CA
        public static let greenA100                = Color(hex: 0xB9F6CA)!
        
        /// SwifterSwift: hex #69F0AE
        public static let greenA200                = Color(hex: 0x69F0AE)!
        
        /// SwifterSwift: hex #00E676
        public static let greenA400                = Color(hex: 0x00E676)!
        
        /// SwifterSwift: hex #00C853
        public static let greenA700                = Color(hex: 0x00C853)!
        
        /// SwifterSwift: color lightGreen500
        public static let lightGreen            = lightGreen500
        
        /// SwifterSwift: hex #F1F8E9
        public static let lightGreen50            = Color(hex: 0xF1F8E9)!
        
        /// SwifterSwift: hex #DCEDC8
        public static let lightGreen100            = Color(hex: 0xDCEDC8)!
        
        /// SwifterSwift: hex #C5E1A5
        public static let lightGreen200            = Color(hex: 0xC5E1A5)!
        
        /// SwifterSwift: hex #AED581
        public static let lightGreen300            = Color(hex: 0xAED581)!
        
        /// SwifterSwift: hex #9CCC65
        public static let lightGreen400            = Color(hex: 0x9CCC65)!
        
        /// SwifterSwift: hex #8BC34A
        public static let lightGreen500            = Color(hex: 0x8BC34A)!
        
        /// SwifterSwift: hex #7CB342
        public static let lightGreen600            = Color(hex: 0x7CB342)!
        
        /// SwifterSwift: hex #689F38
        public static let lightGreen700            = Color(hex: 0x689F38)!
        
        /// SwifterSwift: hex #558B2F
        public static let lightGreen800            = Color(hex: 0x558B2F)!
        
        /// SwifterSwift: hex #33691E
        public static let lightGreen900            = Color(hex: 0x33691E)!
        
        /// SwifterSwift: hex #CCFF90
        public static let lightGreenA100        = Color(hex: 0xCCFF90)!
        
        /// SwifterSwift: hex #B2FF59
        public static let lightGreenA200        = Color(hex: 0xB2FF59)!
        
        /// SwifterSwift: hex #76FF03
        public static let lightGreenA400        = Color(hex: 0x76FF03)!
        
        /// SwifterSwift: hex #64DD17
        public static let lightGreenA700        = Color(hex: 0x64DD17)!
        
        /// SwifterSwift: color lime500
        public static let lime                    = lime500
        
        /// SwifterSwift: hex #F9FBE7
        public static let lime50                = Color(hex: 0xF9FBE7)!
        
        /// SwifterSwift: hex #F0F4C3
        public static let lime100                = Color(hex: 0xF0F4C3)!
        
        /// SwifterSwift: hex #E6EE9C
        public static let lime200                = Color(hex: 0xE6EE9C)!
        
        /// SwifterSwift: hex #DCE775
        public static let lime300                = Color(hex: 0xDCE775)!
        
        /// SwifterSwift: hex #D4E157
        public static let lime400                = Color(hex: 0xD4E157)!
        
        /// SwifterSwift: hex #CDDC39
        public static let lime500                = Color(hex: 0xCDDC39)!
        
        /// SwifterSwift: hex #C0CA33
        public static let lime600                = Color(hex: 0xC0CA33)!
        
        /// SwifterSwift: hex #AFB42B
        public static let lime700                = Color(hex: 0xAFB42B)!
        
        /// SwifterSwift: hex #9E9D24
        public static let lime800                = Color(hex: 0x9E9D24)!
        
        /// SwifterSwift: hex #827717
        public static let lime900                = Color(hex: 0x827717)!
        
        /// SwifterSwift: hex #F4FF81
        public static let limeA100                = Color(hex: 0xF4FF81)!
        
        /// SwifterSwift: hex #EEFF41
        public static let limeA200                = Color(hex: 0xEEFF41)!
        
        /// SwifterSwift: hex #C6FF00
        public static let limeA400                = Color(hex: 0xC6FF00)!
        
        /// SwifterSwift: hex #AEEA00
        public static let limeA700                = Color(hex: 0xAEEA00)!
        
        /// SwifterSwift: color yellow500
        public static let yellow                = yellow500
        
        /// SwifterSwift: hex #FFFDE7
        public static let yellow50                = Color(hex: 0xFFFDE7)!
        
        /// SwifterSwift: hex #FFF9C4
        public static let yellow100                = Color(hex: 0xFFF9C4)!
        
        /// SwifterSwift: hex #FFF59D
        public static let yellow200                = Color(hex: 0xFFF59D)!
        
        /// SwifterSwift: hex #FFF176
        public static let yellow300                = Color(hex: 0xFFF176)!
        
        /// SwifterSwift: hex #FFEE58
        public static let yellow400                = Color(hex: 0xFFEE58)!
        
        /// SwifterSwift: hex #FFEB3B
        public static let yellow500                = Color(hex: 0xFFEB3B)!
        
        /// SwifterSwift: hex #FDD835
        public static let yellow600                = Color(hex: 0xFDD835)!
        
        /// SwifterSwift: hex #FBC02D
        public static let yellow700                = Color(hex: 0xFBC02D)!
        
        /// SwifterSwift: hex #F9A825
        public static let yellow800                = Color(hex: 0xF9A825)!
        
        /// SwifterSwift: hex #F57F17
        public static let yellow900                = Color(hex: 0xF57F17)!
        
        /// SwifterSwift: hex #FFFF8D
        public static let yellowA100            = Color(hex: 0xFFFF8D)!
        
        /// SwifterSwift: hex #FFFF00
        public static let yellowA200            = Color(hex: 0xFFFF00)!
        
        /// SwifterSwift: hex #FFEA00
        public static let yellowA400            = Color(hex: 0xFFEA00)!
        
        /// SwifterSwift: hex #FFD600
        public static let yellowA700            = Color(hex: 0xFFD600)!
        
        /// SwifterSwift: color amber500
        public static let amber                    = amber500
        
        /// SwifterSwift: hex #FFF8E1
        public static let amber50                = Color(hex: 0xFFF8E1)!
        
        /// SwifterSwift: hex #FFECB3
        public static let amber100                = Color(hex: 0xFFECB3)!
        
        /// SwifterSwift: hex #FFE082
        public static let amber200                = Color(hex: 0xFFE082)!
        
        /// SwifterSwift: hex #FFD54F
        public static let amber300                = Color(hex: 0xFFD54F)!
        
        /// SwifterSwift: hex #FFCA28
        public static let amber400                = Color(hex: 0xFFCA28)!
        
        /// SwifterSwift: hex #FFC107
        public static let amber500                = Color(hex: 0xFFC107)!
        
        /// SwifterSwift: hex #FFB300
        public static let amber600                = Color(hex: 0xFFB300)!
        
        /// SwifterSwift: hex #FFA000
        public static let amber700                = Color(hex: 0xFFA000)!
        
        /// SwifterSwift: hex #FF8F00
        public static let amber800                = Color(hex: 0xFF8F00)!
        
        /// SwifterSwift: hex #FF6F00
        public static let amber900                = Color(hex: 0xFF6F00)!
        
        /// SwifterSwift: hex #FFE57F
        public static let amberA100                = Color(hex: 0xFFE57F)!
        
        /// SwifterSwift: hex #FFD740
        public static let amberA200                = Color(hex: 0xFFD740)!
        
        /// SwifterSwift: hex #FFC400
        public static let amberA400                = Color(hex: 0xFFC400)!
        
        /// SwifterSwift: hex #FFAB00
        public static let amberA700                = Color(hex: 0xFFAB00)!
        
        /// SwifterSwift: color orange500
        public static let orange                = orange500
        
        /// SwifterSwift: hex #FFF3E0
        public static let orange50                = Color(hex: 0xFFF3E0)!
        
        /// SwifterSwift: hex #FFE0B2
        public static let orange100                = Color(hex: 0xFFE0B2)!
        
        /// SwifterSwift: hex #FFCC80
        public static let orange200                = Color(hex: 0xFFCC80)!
        
        /// SwifterSwift: hex #FFB74D
        public static let orange300                = Color(hex: 0xFFB74D)!
        
        /// SwifterSwift: hex #FFA726
        public static let orange400                = Color(hex: 0xFFA726)!
        
        /// SwifterSwift: hex #FF9800
        public static let orange500                = Color(hex: 0xFF9800)!
        
        /// SwifterSwift: hex #FB8C00
        public static let orange600                = Color(hex: 0xFB8C00)!
        
        /// SwifterSwift: hex #F57C00
        public static let orange700                = Color(hex: 0xF57C00)!
        
        /// SwifterSwift: hex #EF6C00
        public static let orange800                = Color(hex: 0xEF6C00)!
        
        /// SwifterSwift: hex #E65100
        public static let orange900                = Color(hex: 0xE65100)!
        
        /// SwifterSwift: hex #FFD180
        public static let orangeA100            = Color(hex: 0xFFD180)!
        
        /// SwifterSwift: hex #FFAB40
        public static let orangeA200            = Color(hex: 0xFFAB40)!
        
        /// SwifterSwift: hex #FF9100
        public static let orangeA400            = Color(hex: 0xFF9100)!
        
        /// SwifterSwift: hex #FF6D00
        public static let orangeA700            = Color(hex: 0xFF6D00)!
        
        /// SwifterSwift: color deepOrange500
        public static let deepOrange            = deepOrange500
        
        /// SwifterSwift: hex #FBE9E7
        public static let deepOrange50            = Color(hex: 0xFBE9E7)!
        
        /// SwifterSwift: hex #FFCCBC
        public static let deepOrange100            = Color(hex: 0xFFCCBC)!
        
        /// SwifterSwift: hex #FFAB91
        public static let deepOrange200            = Color(hex: 0xFFAB91)!
        
        /// SwifterSwift: hex #FF8A65
        public static let deepOrange300            = Color(hex: 0xFF8A65)!
        
        /// SwifterSwift: hex #FF7043
        public static let deepOrange400            = Color(hex: 0xFF7043)!
        
        /// SwifterSwift: hex #FF5722
        public static let deepOrange500            = Color(hex: 0xFF5722)!
        
        /// SwifterSwift: hex #F4511E
        public static let deepOrange600            = Color(hex: 0xF4511E)!
        
        /// SwifterSwift: hex #E64A19
        public static let deepOrange700            = Color(hex: 0xE64A19)!
        
        /// SwifterSwift: hex #D84315
        public static let deepOrange800            = Color(hex: 0xD84315)!
        
        /// SwifterSwift: hex #BF360C
        public static let deepOrange900            = Color(hex: 0xBF360C)!
        
        /// SwifterSwift: hex #FF9E80
        public static let deepOrangeA100        = Color(hex: 0xFF9E80)!
        
        /// SwifterSwift: hex #FF6E40
        public static let deepOrangeA200        = Color(hex: 0xFF6E40)!
        
        /// SwifterSwift: hex #FF3D00
        public static let deepOrangeA400        = Color(hex: 0xFF3D00)!
        
        /// SwifterSwift: hex #DD2C00
        public static let deepOrangeA700        = Color(hex: 0xDD2C00)!
        
        /// SwifterSwift: color brown500
        public static let brown                    = brown500
        
        /// SwifterSwift: hex #EFEBE9
        public static let brown50                = Color(hex: 0xEFEBE9)!
        
        /// SwifterSwift: hex #D7CCC8
        public static let brown100                = Color(hex: 0xD7CCC8)!
        
        /// SwifterSwift: hex #BCAAA4
        public static let brown200                = Color(hex: 0xBCAAA4)!
        
        /// SwifterSwift: hex #A1887F
        public static let brown300                = Color(hex: 0xA1887F)!
        
        /// SwifterSwift: hex #8D6E63
        public static let brown400                = Color(hex: 0x8D6E63)!
        
        /// SwifterSwift: hex #795548
        public static let brown500                = Color(hex: 0x795548)!
        
        /// SwifterSwift: hex #6D4C41
        public static let brown600                = Color(hex: 0x6D4C41)!
        
        /// SwifterSwift: hex #5D4037
        public static let brown700                = Color(hex: 0x5D4037)!
        
        /// SwifterSwift: hex #4E342E
        public static let brown800                = Color(hex: 0x4E342E)!
        
        /// SwifterSwift: hex #3E2723
        public static let brown900                = Color(hex: 0x3E2723)!
        
        /// SwifterSwift: color grey500
        public static let grey                    = grey500
        
        /// SwifterSwift: hex #FAFAFA
        public static let grey50                = Color(hex: 0xFAFAFA)!
        
        /// SwifterSwift: hex #F5F5F5
        public static let grey100                = Color(hex: 0xF5F5F5)!
        
        /// SwifterSwift: hex #EEEEEE
        public static let grey200                = Color(hex: 0xEEEEEE)!
        
        /// SwifterSwift: hex #E0E0E0
        public static let grey300                = Color(hex: 0xE0E0E0)!
        
        /// SwifterSwift: hex #BDBDBD
        public static let grey400                = Color(hex: 0xBDBDBD)!
        
        /// SwifterSwift: hex #9E9E9E
        public static let grey500                = Color(hex: 0x9E9E9E)!
        
        /// SwifterSwift: hex #757575
        public static let grey600                = Color(hex: 0x757575)!
        
        /// SwifterSwift: hex #616161
        public static let grey700                = Color(hex: 0x616161)!
        
        /// SwifterSwift: hex #424242
        public static let grey800                = Color(hex: 0x424242)!
        
        /// SwifterSwift: hex #212121
        public static let grey900                = Color(hex: 0x212121)!
        
        /// SwifterSwift: color blueGrey500
        public static let blueGrey                = blueGrey500
        
        /// SwifterSwift: hex #ECEFF1
        public static let blueGrey50            = Color(hex: 0xECEFF1)!
        
        /// SwifterSwift: hex #CFD8DC
        public static let blueGrey100            = Color(hex: 0xCFD8DC)!
        
        /// SwifterSwift: hex #B0BEC5
        public static let blueGrey200            = Color(hex: 0xB0BEC5)!
        
        /// SwifterSwift: hex #90A4AE
        public static let blueGrey300            = Color(hex: 0x90A4AE)!
        
        /// SwifterSwift: hex #78909C
        public static let blueGrey400            = Color(hex: 0x78909C)!
        
        /// SwifterSwift: hex #607D8B
        public static let blueGrey500            = Color(hex: 0x607D8B)!
        
        /// SwifterSwift: hex #546E7A
        public static let blueGrey600            = Color(hex: 0x546E7A)!
        
        /// SwifterSwift: hex #455A64
        public static let blueGrey700            = Color(hex: 0x455A64)!
        
        /// SwifterSwift: hex #37474F
        public static let blueGrey800            = Color(hex: 0x37474F)!
        
        /// SwifterSwift: hex #263238
        public static let blueGrey900            = Color(hex: 0x263238)!
        
        /// SwifterSwift: hex #000000
        public static let black                    = Color(hex: 0x000000)!
        
        /// SwifterSwift: hex #FFFFFF
        public static let white                    = Color(hex: 0xFFFFFF)!
    }
    
}

extension Extensible where Base: UIColor {
    public static var random: UIColor {
        let red = CGFloat.random(in: 0...255)
        let green = CGFloat.random(in: 0...255)
        let blue = CGFloat.random(in: 0...255)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    public func lighten(by percentage: CGFloat = 0.2) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        base.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: min(red + percentage, 1.0),
                       green: min(green + percentage, 1.0),
                       blue: min(blue + percentage, 1.0),
                       alpha: alpha)
    }
    
    public func darken(by percentage: CGFloat = 0.2) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        base.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: min(red - percentage, 1.0),
                       green: min(green - percentage, 1.0),
                       blue: min(blue - percentage, 1.0),
                       alpha: alpha)
    }
}
