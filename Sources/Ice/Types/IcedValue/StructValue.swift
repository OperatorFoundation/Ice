//
//  StructValue.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/22/23.
//

import Foundation

import Datable
import PotentCodables

public struct StructValue: Codable
{
//    public typealias Child = IcedValue
//    public typealias Selector = FieldCodingKey

    public var fields: [FieldValue]

//    public var selectors: [Selector]
//    {
//        var results: [Selector] = []
//        for field in self.fields
//        {
//            results.append(FieldCodingKey(field: field))
//        }
//
//        return results
//    }

    public init(fields: [FieldValue])
    {
        self.fields = fields
    }

//    public func get(selector: Selector) throws -> Child
//    {
//        for field in fields
//        {
//            if field.name.hashValue == selector.intValue
//            {
//                return field.value
//            }
//        }
//
//        throw IcedValueError.badSelector
//    }
//
//    public func put(selector: Selector, value newValue: Child) throws -> Self
//    {
//        var results: [FieldValue] = []
//        for field in self.fields
//        {
//            if field.name.hashValue == selector.intValue
//            {
//                let newField = FieldValue(name: field.name, value: newValue)
//                results.append(newField)
//            }
//            else
//            {
//                results.append(field)
//            }
//        }
//
//        return StructValue(fields: results) as! Self // FIXME - why?
//    }
}

extension StructValue: Equatable
{
    public static func == (lhs: StructValue, rhs: StructValue) -> Bool
    {
        return lhs.fields == rhs.fields
    }
}

extension StructValue: Hashable
{
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine((self.fields))
    }
}

extension StructValue: Value
{
    public var isNull: Bool
    {
        return false
    }

    public var unwrapped: Any?
    {
        return nil // FIXME
    }
}

public struct FieldCodingKey: CodingKey
{
    public var intValue: Int?
    {
        return hash
    }

    public var stringValue: String
    {
        return String(self.hash)
    }

    let hash: Int

    public init(field: FieldValue)
    {
        self.hash = field.name.hashValue
    }

    public init?(intValue: Int)
    {
        self.hash = intValue
    }

    public init?(stringValue: String)
    {
        self.hash = stringValue.hashValue
    }
}
