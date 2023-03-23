//
//  ClassValue.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/22/23.
//

import Foundation

import Datable
import PotentCodables

public struct ClassValue: Codable
{
//    public typealias Child = IcedValue
//    public typealias Selector = FieldCodingKey

    public let fields: [FieldValue]

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
//        return ClassValue(fields: results)
//    }
}

extension ClassValue: Equatable
{
    public static func == (lhs: ClassValue, rhs: ClassValue) -> Bool
    {
        return lhs.fields == rhs.fields
    }
}

extension ClassValue: Hashable
{
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(self.fields)
    }
}

public struct FieldValue: Codable
{
    public let name: String
    public let value: IcedValue

    public enum CodingKeys: Int, CodingKey
    {
        case name
        case value
    }

    public init(name: String, value: IcedValue)
    {
        self.name = name
        self.value = value
    }

    public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let value = try container.decode(IcedValue.self, forKey: .value)

        self.name = name
        self.value = value
    }
}

extension FieldValue: Equatable
{
    
}

extension FieldValue: Hashable
{

}
