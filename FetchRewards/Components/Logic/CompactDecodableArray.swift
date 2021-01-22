//
//  CompactDecodableArray.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/21/21.
//

import Foundation

class CompactDecodableArray<Element>: Decodable where Element: Decodable {
    var elements = [Element]()
    required init(from decoder: Decoder) throws {
        guard var unkeyedContainer = try? decoder.unkeyedContainer() else { return }
        while !unkeyedContainer.isAtEnd {
            if let value = try? unkeyedContainer.decode(Element.self) {
                elements.append(value)
            } else {
                unkeyedContainer.skip()
            }
        }
    }
}

// https://forums.swift.org/t/pitch-unkeyeddecodingcontainer-movenext-to-skip-items-in-deserialization/22151/17
private struct Empty: Decodable { }

extension UnkeyedDecodingContainer {
    mutating func skip() { _ = try? decode(Empty.self) }
}

