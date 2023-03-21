//
//  Transforms.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/21/23.
//

import Foundation

import PotentCodables

final public class IceEncoderTransform: InternalEncoderTransform
{
    public typealias Value = BasicValue
    public typealias Options = IceEncoderOptions
    public typealias State = IceState

    public static var emptyKeyedContainer: BasicValue = .Nil // FIXME
    public static var emptyUnkeyedContainer: BasicValue = .Nil // FIXME

    public static func box(_ value: Bool, encoder: IVE) throws -> BasicValue
    {
        return .Bool(value)
    }

    public static func box(_ value: Int, encoder: IVE) throws -> BasicValue
    {
        return .Int(value)
    }

    public static func box(_ value: Int8, encoder: IVE) throws -> BasicValue
    {
        return .Int8(value)
    }

    public static func box(_ value: Int16, encoder: IVE) throws -> BasicValue
    {
        return .Int16(value)
    }

    public static func box(_ value: Int32, encoder: IVE) throws -> BasicValue
    {
        return .Int32(value)
    }

    public static func box(_ value: Int64, encoder: IVE) throws -> BasicValue
    {
        return .Int64(value)
    }

    public static func box(_ value: UInt, encoder: IVE) throws -> BasicValue
    {
        return .UInt(value)
    }

    public static func box(_ value: UInt8, encoder: IVE) throws -> BasicValue
    {
        return .UInt8(value)
    }

    public static func box(_ value: UInt16, encoder: IVE) throws -> BasicValue
    {
        return .UInt16(value)
    }

    public static func box(_ value: UInt32, encoder: IVE) throws -> BasicValue
    {
        return .UInt32(value)
    }

    public static func box(_ value: UInt64, encoder: IVE) throws -> BasicValue
    {
        return .UInt64(value)
    }

    public static func box(_ value: String, encoder: IVE) throws -> BasicValue
    {
        throw TransformsError.unimplemented // FIXME
    }

    public static func box(_ value: Float, encoder: IVE) throws -> BasicValue
    {
        throw TransformsError.unimplemented // FIXME
    }

    public static func box(_ value: Double, encoder: IVE) throws -> BasicValue
    {
        throw TransformsError.unimplemented // FIXME
    }

    public static func boxNil(encoder: IVE) throws -> BasicValue
    {
        return .Nil
    }

    public static func unkeyedValuesToValue(_ values: UnkeyedValues, encoder: IVE) throws -> BasicValue
    {
        throw TransformsError.unimplemented // FIXME
    }

    public static func keyedValuesToValue(_ values: KeyedValues, encoder: IVE) throws -> BasicValue
    {
        throw TransformsError.unimplemented // FIXME
    }
}

extension IceEncoderTransform: InternalValueSerializer
{
    public static func data(from: BasicValue, options: IceEncoderOptions) throws -> Data
    {
        return from.data
    }
}

extension IceEncoderTransform: InternalValueStringifier
{
    public static func string(from: BasicValue, options: IceEncoderOptions) throws -> String
    {
        let data = from.data
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(data)
        let string = encoded.string
        return string
    }
}

final public class IceDecoderTransform: InternalDecoderTransform
{
    public typealias Value = BasicValue
    public typealias Options = IceDecoderOptions
    public typealias State = IceState

    public static var nilValue: BasicValue = .Nil

    public static func unbox(_ value: BasicValue, as type: Bool.Type, decoder: IVD) throws -> Bool?
    {
        switch value
        {
            case .Bool(let value):
                return value

            default:
                return nil
        }
    }

    public static func unbox(_ value: BasicValue, as type: Int.Type, decoder: IVD) throws -> Int?
    {
        throw TransformsError.unimplemented // FIXME
    }

    public static func unbox(_ value: BasicValue, as type: Int8.Type, decoder: IVD) throws -> Int8?
    {
        throw TransformsError.unimplemented // FIXME
    }

    public static func unbox(_ value: BasicValue, as type: Int16.Type, decoder: IVD) throws -> Int16?
    {
        throw TransformsError.unimplemented // FIXME
    }

    public static func unbox(_ value: BasicValue, as type: Int32.Type, decoder: IVD) throws -> Int32?
    {
        throw TransformsError.unimplemented // FIXME
    }

    public static func unbox(_ value: BasicValue, as type: Int64.Type, decoder: IVD) throws -> Int64?
    {
        throw TransformsError.unimplemented // FIXME
    }

    public static func unbox(_ value: BasicValue, as type: UInt.Type, decoder: IVD) throws -> UInt?
    {
        switch value
        {
            case .UInt(let value):
                return value

            default:
                return nil
        }
    }

    public static func unbox(_ value: BasicValue, as type: UInt8.Type, decoder: IVD) throws -> UInt8?
    {
        switch value
        {
            case .UInt8(let value):
                return value

            default:
                return nil
        }
    }

    public static func unbox(_ value: BasicValue, as type: UInt16.Type, decoder: IVD) throws -> UInt16?
    {
        switch value
        {
            case .UInt16(let value):
                return value

            default:
                return nil
        }
    }

    public static func unbox(_ value: BasicValue, as type: UInt32.Type, decoder: IVD) throws -> UInt32?
    {
        switch value
        {
            case .UInt32(let value):
                return value

            default:
                return nil
        }
    }

    public static func unbox(_ value: BasicValue, as type: UInt64.Type, decoder: IVD) throws -> UInt64?
    {
        switch value
        {
            case .UInt64(let value):
                return value

            default:
                return nil
        }
    }

    public static func unbox(_ value: BasicValue, as type: Float.Type, decoder: IVD) throws -> Float?
    {
        throw TransformsError.unimplemented // FIXME
    }

    public static func unbox(_ value: BasicValue, as type: Double.Type, decoder: IVD) throws -> Double?
    {
        throw TransformsError.unimplemented // FIXME
    }

    public static func unbox(_ value: BasicValue, as type: String.Type, decoder: IVD) throws -> String?
    {
        throw TransformsError.unimplemented // FIXME
    }

    public static func valueToUnkeyedValues(_ value: BasicValue, decoder: IVD) throws -> UnkeyedValues?
    {
        throw TransformsError.unimplemented // FIXME
    }

    public static func valueToKeyedValues(_ value: BasicValue, decoder: IVD) throws -> KeyedValues?
    {
        throw TransformsError.unimplemented // FIXME
    }
}

extension IceDecoderTransform: InternalValueDeserializer
{
    public static func value(from: Data, options: IceDecoderOptions) throws -> BasicValue
    {
        guard let result = BasicValue(data: from) else
        {
            throw TransformsError.decodeFailure
        }

        return result
    }
}

extension IceDecoderTransform: InternalValueParser
{
    public static func value(from: String, options: IceDecoderOptions) throws -> BasicValue
    {
        let data = from.data
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(Data.self, from: data)

        guard let result = BasicValue(data: decoded) else
        {
            throw TransformsError.decodeFailure
        }

        return result
    }
}

public enum TransformsError: Error
{
    case unimplemented
    case decodeFailure
}
