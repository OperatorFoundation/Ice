//
//  Type.swift
//
//
//  Created by Dr. Brandon Wiley on 3/12/23.
//

import Foundation

import Datable

//public indirect enum IcedType: Codable
//{
//    case Basic(BasicType)
//    case String(StringType)
//    case Array(ArrayType)
//    case Dictionary(DictionaryType)
//    case DictionaryEntry(DictionaryEntryType)
//    case Struct(StructType)
//    case Class(ClassType)
//    case Field(FieldType)
//}
//
//extension IcedType: Container
//{
//    public typealias Child = IcedType
//    public typealias Selector = Int
//
//    public var selectors: [Selector]
//    {
//        switch self
//        {
//            case .Basic(_):
//                return []
//
//            case .String(_):
//                return []
//
//            case .Array(let value):
//                var results: [Selector] = []
//                for index in 0..<value.elements.count
//                {
//                    results.append(index)
//                }
//
//                return results
//
//            case .Dictionary(let value):
//                var results: [Selector] = []
//                for index in 0..<value.entries.count
//                {
//                    results.append(index)
//                }
//
//                return results
//
//            case .DictionaryEntry(_):
//                return [0, 1]
//
//            case .Struct(let value):
//                var results: [Selector] = []
//                for index in 0..<value.fields.count
//                {
//                    results.append(index)
//                }
//
//                return results
//
//            case .Class(let value):
//                var results: [Selector] = []
//                for index in 0..<value.fields.count
//                {
//                    results.append(index)
//                }
//
//                return results
//
//            case .Field(_):
//                return [0]
//        }
//    }
//
//    public func get(selector: Selector) throws -> IcedType
//    {
//        switch self
//        {
//            case .Basic(_):
//                throw IcedTypeError.badSelector(selector)
//
//            case .String(_):
//                throw IcedTypeError.badSelector(selector)
//
//            case .Array(let value):
//                guard (selector >= 0) && (selector < value.elements.count) else
//                {
//                    throw IcedTypeError.badSelector(selector)
//                }
//
//                return value.elements[selector]
//
//            case .Dictionary(let value):
//                guard (selector >= 0) && (selector < value.entries.count) else
//                {
//                    throw IcedTypeError.badSelector(selector)
//                }
//
//                return .DictionaryEntry(value.entries[selector])
//
//            case .DictionaryEntry(let value):
//                switch selector
//                {
//                    case 0:
//                        return value.keyType
//
//                    case 1:
//                        return value.valueType
//
//                    default:
//                        throw IcedTypeError.badSelector(selector)
//                }
//
//            case .Struct(let value):
//                guard (selector >= 0) && (selector < value.fields.count) else
//                {
//                    throw IcedTypeError.badSelector(selector)
//                }
//
//                return value.fields[selector].type
//
//            case .Class(let value):
//                guard (selector >= 0) && (selector < value.fields.count) else
//                {
//                    throw IcedTypeError.badSelector(selector)
//                }
//
//                return value.fields[selector].type
//
//            case .Field(_):
//                throw IcedTypeError.badSelector(selector)
//        }
//    }
//
//    public func put(selector: Selector, value: IcedType) throws -> Self
//    {
//
//    }
//}
//
//public enum ConcreteTypeSelector: Int, Codable
//{
//    case Basic = 10
//    case String = 20
//    case Array = 30
//    case Dictionary = 40
//    case Struct = 50
//    case Class = 60
//}
//

public enum BasicType: Int, Codable
{
    case Nil = 2
    case Bool = 3
    case Double = 4
    case Float = 5
    case Int = 6
    case Int8 = 7
    case Int16 = 8
    case Int32 = 9
    case Int64 = 10
    case UInt = 11
    case UInt8 = 12
    case UInt16 = 13
    case UInt32 = 14
    case UInt64 = 15
}

func intToByteData(_ int: Int) -> Data
{
    return UInt8(int).data
}

func byteDataToInt(_ data: Data) -> Int?
{
    guard data.count == 1 else
    {
        return nil
    }

    let uint8 = UInt8(data: data)
    let int = Int(uint8)
    return int
}

extension BasicType: MaybeDatable
{
    public var data: Data
    {
        return intToByteData(self.rawValue)
    }

    public init?(data: Data)
    {
        guard let int = byteDataToInt(data) else
        {
            return nil
        }

        self.init(rawValue: int)
    }
}

//
//public struct StringType: Codable
//{
//    let length: Int
//
//    public init(length: Int)
//    {
//        self.length = length
//    }
//}
//
//public struct ArrayType: Codable
//{
//    let elements: [IcedType]
//
//    public enum CodingKeys: Int, CodingKey
//    {
//        case elements
//    }
//
//    public init()
//    {
//        self.elements = []
//    }
//
//    public init(from decoder: Decoder) throws
//    {
//        var container = try decoder.container(keyedBy: CodingKeys.self)
//        let elements = try container.decode([IcedType].self, forKey: .elements)
//
//        self.elements = elements
//    }
//
//    public func encode(to encoder: Encoder) throws
//    {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.elements, forKey: .elements)
//    }
//}
//
//public struct DictionaryType: Codable
//{
//    public var entries: [DictionaryEntryType]
//
//    public init()
//    {
//        self.entries = []
//    }
//
//    public enum CodingKeys: Int, CodingKey
//    {
//        case entries
//    }
//
//    public init(from decoder: Decoder) throws
//    {
//        var container = try decoder.container(keyedBy: CodingKeys.self)
//        let entries = try container.decode([DictionaryEntryType].self, forKey: .entries)
//
//        self.entries = entries
//    }
//
//    public func encode(to encoder: Encoder) throws
//    {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.entries, forKey: .entries)
//    }
//}
//
//public struct DictionaryEntryType: Codable
//{
//    let keyType: IcedType
//    let valueType: IcedType
//
//    public init(keyType: IcedType, valueType: IcedType)
//    {
//        self.keyType = keyType
//        self.valueType = valueType
//    }
//
//    public enum CodingKeys: Int, CodingKey
//    {
//        case keyType
//        case valueType
//    }
//
//    public init(from decoder: Decoder) throws
//    {
//        var container = try decoder.container(keyedBy: CodingKeys.self)
//        let keyType = try container.decode(IcedType.self, forKey: .keyType)
//        let valueType = try container.decode(IcedType.self, forKey: .valueType)
//
//        self.keyType = keyType
//        self.valueType = valueType
//    }
//
//    public func encode(to encoder: Encoder) throws
//    {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.keyType, forKey: .keyType)
//        try container.encode(self.valueType, forKey: .valueType)
//    }
//}
//
//public struct StructType: Codable
//{
//    public let fields: [FieldType]
//
//    public init(fields: [FieldType])
//    {
//        self.fields = fields
//    }
//}
//
//public struct ClassType: Codable
//{
//    public let fields: [FieldType]
//
//    public init(fields: [FieldType])
//    {
//        self.fields = fields
//    }
//}
//
//public struct FieldType: Codable
//{
//    public let name: String
//    public let type: IcedType
//
//    public enum CodingKeys: Int, CodingKey
//    {
//        case name
//        case type
//    }
//
//    public init(name: String, type: IcedType)
//    {
//        self.name = name
//        self.type = type
//    }
//
//    public init(from decoder: Decoder) throws
//    {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let name = try container.decode(String.self, forKey: .name)
//        let type = try container.decode(IcedType.self, forKey: .type)
//
//        self.name = name
//        self.type = type
//    }
//}
//
//// NOTE: Assumes and requires 64-bit Int/UInt
//public let sizes: [BasicType: Int] =
//[
//    .Nil:    1,
//    .Bool:   1,
//    .Double: 8,
//    .Float:  4,
//    .Int:    8,
//    .Int8:   1,
//    .Int16:  2,
//    .Int32:  4,
//    .Int64:  8,
//    .UInt:   8,
//    .UInt8:  1,
//    .UInt16: 2,
//    .UInt32: 4,
//    .UInt64: 8,
//]
//
//public enum IcedTypeError<Selector>: Error
//{
//    case badSelector(Selector)
//}
