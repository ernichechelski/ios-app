//
//  UUID+Extensions.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import Foundation
extension UUID {

    init(text: String) throws {
        let hash = text.sha256().padding(rightTo: 30, withPad: "0")

        let finalHash = [
            hash.suffix(4 + 4 + 4 + 12).prefix(8),
            hash.suffix(4 + 4 + 12).prefix(4),
            hash.suffix(4 + 12).prefix(4),
            hash.suffix(12).prefix(4),
            hash.suffix(12)
        ].joined(separator: "-")

        self = try UUID(uuidString: finalHash).throwing()
    }
}
