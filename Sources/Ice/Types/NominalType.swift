//
//  NominalType.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/14/23.
//

import Foundation

public indirect enum NominalType: Codable
{
    case Basic(NominalBasicType)
    case Array(NominalArrayType)
    case Dictionary(NominalDictionaryType)
    case Constructed(NominalConstructedType)
    case Generic(NominalGenericType)
}

public enum NominalBasicType: Int, Codable
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

public struct NominalArrayType: Codable
{
    public let elementType: NominalType

    public init(elementType: NominalType)
    {
        self.elementType = elementType
    }
}

public struct NominalDictionaryType: Codable
{
    public let keyType: NominalType
    public let valueType: NominalType

    public init(keyType: NominalType, valueType: NominalType)
    {
        self.keyType = keyType
        self.valueType = valueType
    }
}

public struct NominalConstructedType: Codable
{
    public let name: String

    public init(name: String)
    {
        self.name = name
    }
}

public struct NominalGenericType: Codable
{
    public let name: String
    public let genericParameters: [NominalType]

    public init(name: String, genericParameters: [NominalType])
    {
        self.name = name
        self.genericParameters = genericParameters
    }
}
