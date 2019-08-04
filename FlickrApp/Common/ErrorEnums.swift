//
//  ErrorEnums.swift
//  FlickrApp
//
//  Created by Mahendra Yadav on 04/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import Foundation

enum FlickrServiceError: Error {
    case invalidImageData
    case invalidRequest
    case parsingFailed
    case noData
    /// Error when the retrieved image could not be parsed.
}

extension FlickrServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidImageData:
            return NSLocalizedString(
                Contstants.Message.INVALID_DATA,
                comment: ""
            )
        case .invalidRequest:
            return NSLocalizedString(
                Contstants.Message.ERROR,
                comment: ""
            )
        case .parsingFailed:
            return NSLocalizedString(
                Contstants.Message.PARSING_ERROR,
                comment: ""
            )
        case .noData:
            return NSLocalizedString(
                Contstants.Message.NO_DATA,
                comment: ""
            )
        }
    }
}
