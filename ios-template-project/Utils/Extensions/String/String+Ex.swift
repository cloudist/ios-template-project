//
//  String+Ex.swift
//  Extensions
//
//  Created by liubo on 2018/8/27.
//

import UIKit
import QuartzCore

extension String: ExtensibleCompatible {}

extension Extensible where Base == String {
    
    public var base64Encoded: String? {
        return base.data(using: .utf8)?.base64EncodedString()
    }
    
    public var base64Decoded: String? {
        guard let data = Data(base64Encoded: base) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// 适用于 base64 的字符串
    public var urlSafeString: String {
        var x = base.replacingOccurrences(of: "/", with: "_")
        x = x.replacingOccurrences(of: "+", with: "-")
        x = x.replacingOccurrences(of: "=", with: "")
        return x
    }
    
    
    /// 适用于 base64 的字符串
    public var urlUnsafeString: String {
        var x = base.replacingOccurrences(of: "_", with: "/")
        x = x.replacingOccurrences(of: "-", with: "+")
        let mod4 = x.count % 4
        if mod4 > 0 {
            let y = ("====" as NSString).substring(to: 4 - mod4)
            x.append(y)
        }
        return x
    }
    
    public var urlEncoded: String {
        return base.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    public var urlDecoded: String {
        return base.removingPercentEncoding ?? base
    }
    
    public var camelCased: String {
        let source = base.lowercased()
        let first = source[..<source.index(after: source.startIndex)]
        if source.contains(" ") {
            let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
            let camel = connected.replacingOccurrences(of: "\n", with: "")
            let rest = String(camel.dropFirst())
            return first + rest
        }
        let rest = String(source.dropFirst())
        return first + rest
    }
    
    /// SwifterSwift: Check if string contains one or more emojis.
    ///
    ///        "Hello 😀".containEmoji -> true
    ///
    public var containEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in base.unicodeScalars {
            switch scalar.value {
            case 0x3030, 0x00AE, 0x00A9, // Special Characters
            0x1D000...0x1F77F, // Emoticons
            0x2100...0x27BF, // Misc symbols and Dingbats
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }
    
    public var isValidEmail: Bool {
        let regex = "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return base.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    public var isValidUrl: Bool {
        return URL(string: base) != nil
    }
    
    public var isValidSchemedUrl: Bool {
        guard let url = URL(string: base) else { return false }
        return url.scheme != nil
    }
    
    public var isValidHttpsUrl: Bool {
        guard let url = URL(string: base) else { return false }
        return url.scheme == "https"
    }
    
    public var isValidHttpUrl: Bool {
        guard let url = URL(string: base) else { return false }
        return url.scheme == "http"
    }
    
    public var url: URL? {
        return URL(string: base)
    }
    
    public var date: Date? {
        let selfLowercased = base.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }
    
    public var dateTime: Date? {
        let selfLowercased = base.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }
    
    public var bool: Bool? {
        let selfLowercased = base.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        switch selfLowercased {
        case "true", "1":
            return true
        case "false", "0":
            return false
        default:
            return nil
        }
    }
    
    public var int: Int? {
        return Int(base)
    }
    
    public var float: Float? {
        return Float(base)
    }
    
    public var double: Double? {
        return Double(base)
    }
    
    public func cgFloat(locale: Locale = .current) -> CGFloat? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: base) as? CGFloat
    }
    
    public func localized(comment: String = "") -> String {
        return NSLocalizedString(base, comment: comment)
    }
    
    public func words() -> [String] {
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let comps = base.components(separatedBy: chararacterSet)
        return comps.filter { !$0.isEmpty }
    }
    
    public var charactersArray: [Character] {
        return Array(base)
    }
    
    public subscript(safe i: Int) -> Character? {
        guard i >= 0 && i < base.count else { return nil }
        return base[base.index(base.startIndex, offsetBy: i)]
    }
    
    public subscript(safe range: CountableRange<Int>) -> String? {
        guard let lowerIndex = base.index(base.startIndex, offsetBy: max(0, range.lowerBound), limitedBy: base.endIndex) else { return nil }
        guard let upperIndex = base.index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: base.endIndex) else { return nil }
        return String(base[lowerIndex..<upperIndex])
    }
    
    public subscript(safe range: ClosedRange<Int>) -> String? {
        guard let lowerIndex = base.index(base.startIndex, offsetBy: max(0, range.lowerBound), limitedBy: base.endIndex) else { return nil }
        guard let upperIndex = base.index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: base.endIndex) else { return nil }
        return String(base[lowerIndex..<upperIndex])
    }
    
    public func copyToPasteboard() {
        UIPasteboard.general.string = base
    }
    
    public func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
        if caseSensitive {
            return base.range(of: string) != nil
        }
        return base.range(of: string, options: .caseInsensitive) != nil
    }
    
    public func random(ofLength length: Int) -> String {
        guard length > 0 else { return "" }
        let baseString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1...length {
            let randomIndex = Int.random(in: 0..<baseString.count)
            let randomCharacter = baseString.ext.charactersArray[randomIndex]
            randomString.append(randomCharacter)
        }
        return randomString
    }
    
    public func UID(_ norm: Int? = nil) -> String {
        let id = norm ?? Int.random(in: 0..<10)
        let context = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let dateComponents = Calendar.current.dateComponents([.day, .hour], from: Date())
        let length = context.count
        var randomString = ""
        randomString.append(context.ext.charactersArray[dateComponents.day!])
        randomString.append(context.ext.charactersArray[dateComponents.hour!])
        randomString.append(context.ext.charactersArray[id % length])
        
        for _ in 1...3 {
            randomString.append(context.ext.charactersArray[Int.random(in: 0..<length)])
            randomString.append(context.ext.charactersArray[Int.random(in: 0..<length)])
            randomString.append(context.ext.charactersArray[Int.random(in: 0..<length)])
        }
        return randomString
    }
    
    public func reverse() -> String {
        let chars = base.reversed()
        return String(chars)
    }
    
    public func slicing(from i: Int, length: Int) -> String? {
        guard length >= 0, i >= 0, i < base.count else { return nil }
        guard i.advanced(by: length) <= base.count else {
            return base.ext[safe: i ..< i.advanced(by: length)]
        }
        
        guard length > 0 else { return "" }
        return base.ext[safe: i ..< i.advanced(by: length)]
    }
    
    public func slice(from start: Int, to end: Int) -> String? {
        guard let lowerIndex = base.index(base.startIndex, offsetBy: max(0, start), limitedBy: base.endIndex) else { return nil }
        guard let upperIndex = base.index(lowerIndex, offsetBy: end - start + 1, limitedBy: base.endIndex) else { return nil }
        return String(base[lowerIndex..<upperIndex])
    }
    
    public func trim() -> String {
        return base.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
