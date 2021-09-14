//
//  DataModel.swift
//  MemriTask
//
//  Created by ashokdy on 15/09/2021.
//

import SwiftUI

enum DataType: String, Codable {
    case image = "Image"
    case text = "Text"
    case row = "Row"
    case column = "Column"
    case stack = "Stack"
}

enum DataAlignment: String, Codable {
    case leading
    case center
    case trailing
    
    func actual() -> Alignment {
        switch self {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        }
    }
}

enum FontStyle: String, Codable {
    case bold12 = "bold 12em"
    
    func actual() -> Font {
        switch self {
        case .bold12:
            return Font.system(size: 12, weight: .bold)
        }
    }
}

struct DataResponse: Codable {
    let type: DataType
    let height, width: String
    let url: String?
    let alignment: DataAlignment?
    let font: FontStyle?
    let data: DataWrapper?
}

enum DataWrapper: Codable {
    case string(String)
    case array([String])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode([String].self) {
            self = .array(value)
            return
        }
        
        if let value = try? container.decode(String.self) {
            self = .string(value)
            return
        }
        
        throw DecodingError.typeMismatch(DataWrapper.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DataUnion"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .array(let value):
            try container.encode(value)
        }
    }
    
    public var stringValue: String {
        var result: String
        switch self {
        case let .string(value):
            result = value
        case let .array(value):
            result = value.joined()
        }
        return result
    }
    
    public var arrayValue: [String] {
        var result: [String]
        switch self {
        case let .string(value):
            result = value.components(separatedBy: ",")
        case let .array(value):
            result = value
        }
        return result
    }
}

extension DataResponse: Hashable { }
extension DataType: Hashable { }
extension DataWrapper: Hashable { }
