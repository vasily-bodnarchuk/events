//
//  AppError.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/21/21.
//

import Foundation

enum AppError {
    case network(type: Enums.ErrorType)
    
    class Enums {}
}

extension AppError.Enums {
    enum ErrorType {
        case custom(message: String)
        case nested(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .custom(let message): return message
            case .nested(let error): return error.localizedDescription
            }
        }
    }
}

extension AppError: Error { }
extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .network(let type): return type.errorDescription
        }
    }
}
