//
//  String+Extensions.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import Foundation

extension String {
    mutating func clear() {
        self = ""
    }

    func replaced(text: String, at: Int) -> Self {
        var newStr = ""
        for (index, element) in enumerated() {
            if index == at {
                newStr.append(text)
            } else {
                newStr.append(element)
            }
        }
        return newStr
    }

    func padding(leftTo paddedLength: Int, withPad pad: String = " ", startingAt padStart: Int = 0) -> String {
        let rightPadded = padding(toLength: max(count, paddedLength), withPad: pad, startingAt: padStart)
        return "".padding(toLength: paddedLength, withPad: rightPadded, startingAt: count % paddedLength)
    }

    func padding(rightTo paddedLength: Int, withPad pad: String = " ", startingAt padStart: Int = 0) -> String {
        padding(toLength: paddedLength, withPad: pad, startingAt: padStart)
    }

    func padding(sidesTo paddedLength: Int, withPad pad: String = " ", startingAt padStart: Int = 0) -> String {
        let rightPadded = padding(toLength: max(count, paddedLength), withPad: pad, startingAt: padStart)
        return "".padding(toLength: paddedLength, withPad: rightPadded, startingAt: (paddedLength + count) / 2 % paddedLength)
    }
}

extension String {
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return stringData.sha256()
        }
        return ""
    }
}
