//
//  DictionaryValue.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/22/23.
//

import Foundation

import Datable
import PotentCodables

public struct DictionaryValue: Codable
{
    public let entries: [DictionaryEntryValue]

    public init(entries: [DictionaryEntryValue])
    {
        self.entries = entries
    }
}

extension DictionaryValue
{
    public var dictionary: [IcedValue: IcedValue]
    {
        var result: [IcedValue: IcedValue] = [:]

        for entry in self.entries
        {
            result[entry.key] = entry.value
        }

        return result
    }
}

extension DictionaryValue: Equatable
{
    public static func == (lhs: DictionaryValue, rhs: DictionaryValue) -> Bool
    {
        return lhs.entries == rhs.entries
    }
}

extension DictionaryValue: Hashable
{
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(self.entries)
    }
}

public struct DictionaryCodingKey: CodingKey
{
    public var intValue: Int?
    {
        return self.index
    }

    public var stringValue: String
    {
        return String(self.index)
    }

    let index: Int

    public init(key: any Hashable)
    {
        self.index = key.hashValue
    }

    public init?(intValue: Int)
    {
        self.index = intValue
    }

    public init?(stringValue: String)
    {
        guard let index = Int(stringValue) else
        {
            return nil
        }

        self.index = index
    }
}

public struct DictionaryEntryValue: Equatable, Hashable, Codable
{
    public let key: IcedValue
    public let value: IcedValue

    public enum CodingKeys: Int, CodingKey
    {
        case key
        case value
    }

    public init(key: IcedValue, value: IcedValue)
    {
        self.key = key
        self.value = value
    }

    public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let key = try container.decode(IcedValue.self, forKey: .key)
        let value = try container.decode(IcedValue.self, forKey: .value)

        self.key = key
        self.value = value
    }

    public func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.key, forKey: .key)
        try container.encode(self.value, forKey: .value)
    }
}
