//
//  Decodable.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/21/21.
//

import Foundation

// MARK: - getting formated string to log JSON models

extension Decodable where Self: Encodable {
    func format(options: JSONEncoder.OutputFormatting) -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = options
        do {
            let jsonData = try encoder.encode(self)
            if let jsonString = String(data: jsonData, encoding: .utf8) { return "\(jsonString)" }
        } catch {
            print("\(error.localizedDescription)")
        }
        return "nil"
    }
}

// extension Encodable {
//    func toJson() -> [String: Any] { return (try? DictionaryEncoder().encode(self)) ?? [:] }
// }

// MARK: - init Decodable element from dictionary

extension Decodable {
    init(from value: Any,
         options: JSONSerialization.WritingOptions = [],
         decoder: JSONDecoder) throws {
        let data = try JSONSerialization.data(withJSONObject: value, options: options)
        self = try decoder.decode(Self.self, from: data)
    }

    init(from value: Any,
         options: JSONSerialization.WritingOptions = [],
         decoderSetupClosure: ((JSONDecoder) -> Void)? = nil) throws {
        let decoder = JSONDecoder()
        decoderSetupClosure?(decoder)
        try self.init(from: value, options: options, decoder: decoder)
    }

    init?(discardingAnErrorFrom value: Any,
          printError: Bool = false,
          options: JSONSerialization.WritingOptions = [],
          decoderSetupClosure: ((JSONDecoder) -> Void)? = nil) {
        do {
            try self.init(from: value, options: options, decoderSetupClosure: decoderSetupClosure)
        } catch {
            if printError { print("\(Self.self) decoding ERROR:\n\(error)") }
            return nil
        }
    }
}

extension Decodable {
    init?(from value: Any, dateFormat: String = "yyyy-MM-dd'T'HH:mm:sszzz", printError: Bool = false) {
        self.init(discardingAnErrorFrom: value, printError: printError) { decoder in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
        }
    }
}
