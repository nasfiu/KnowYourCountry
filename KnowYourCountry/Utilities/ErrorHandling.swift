//
//  ErrorHandling.swift
//  KnowYourCity
//
//  Created by Nasfi on 07/02/21.
//

import Foundation

enum AppErrorCode {
    case none
    case hostNotReachable
    case unexpectedServerResponse(String?, String?) // (message, code)
}

struct AppError: Error {
    let code: AppErrorCode
    let message: String
    let cause: Error?
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        var desc = message
        if let cause = cause {
            let causeMessage = descriptionOf(error: cause)
            desc += " --> Caused by:\n" + causeMessage
        }
        return desc
    }
}

func createError(_ message: String, cause: Error? = nil, code: AppErrorCode = .none) -> AppError {
    AppError(code: code, message: message, cause: cause)
}

func descriptionOf(error: Error) -> String {
    (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
}

func logError(_ error: Error) {
    #if DEBUG
    let message = descriptionOf(error: error)
    print(message)
    #endif
}
