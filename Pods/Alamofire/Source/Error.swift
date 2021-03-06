//
//  Error.swift
//
//  Copyright (c) 2014-2016 Alamofire Software Foundation (http://alamofire.org/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

/// The domain used for creating all Alamofire errors.
public let ErrorDomain = "org.alamofire.error"

/// The custom error codes generated by Alamofire.
public enum ErrorCode: Int {
    case inputStreamReadFailed           = -6000
    case outputStreamWriteFailed         = -6001
    case contentTypeValidationFailed     = -6002
    case statusCodeValidationFailed      = -6003
    case dataSerializationFailed         = -6004
    case stringSerializationFailed       = -6005
    case jsonSerializationFailed         = -6006
    case propertyListSerializationFailed = -6007
}

// MARK: -

/// Custom keys contained within certain NSError `userInfo` dictionaries generated by Alamofire.
public struct ErrorUserInfoKeys {
    /// The content type user info key for a `.ContentTypeValidationFailed` error stored as a `String` value.
    public static let ContentType = "ContentType"

    /// The status code user info key for a `.StatusCodeValidationFailed` error stored as an `Int` value.
    public static let StatusCode = "StatusCode"
}

// MARK: -

extension NSError {
    convenience init(domain: String = ErrorDomain, code: ErrorCode, failureReason: String) {
        self.init(domain: domain, code: code.rawValue, failureReason: failureReason)
    }

    convenience init(domain: String = ErrorDomain, code: Int, failureReason: String) {
        let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
        self.init(domain: domain, code: code, userInfo: userInfo)
    }
}
