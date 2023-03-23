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
    public typealias Value = IcedValue
    public typealias Options = IceEncoderOptions
    public typealias State = IceState

    public static var emptyKeyedContainer: Value = .Leaf(.Basic(.Nil)) // FIXME
    public static var emptyUnkeyedContainer: Value = .Leaf(.Basic(.Nil)) // FIXME

    public static func box(_ value: Bool, encoder: IVE) throws -> Value
    {
        return .Leaf(.Basic(.Bool(value)))
    }

    public static func box(_ value: Int, encoder: IVE) throws -> Value
    {
        return .Leaf(.Basic(.Int(value)))
    }

    public static func box(_ value: Int8, encoder: IVE) throws -> Value
    {
        return .Leaf(.Basic(.Int8(value)))
    }

    public static func box(_ value: Int16, encoder: IVE) throws -> Value
    {
        return .Leaf(.Basic(.Int16(value)))
    }

    public static func box(_ value: Int32, encoder: IVE) throws -> Value
    {
        return .Leaf(.Basic(.Int32(value)))
    }

    public static func box(_ value: Int64, encoder: IVE) throws -> Value
    {
        return .Leaf(.Basic(.Int64(value)))
    }

    public static func box(_ value: UInt, encoder: IVE) throws -> Value
    {
        return .Leaf(.Basic(.UInt(value)))
    }

    public static func box(_ value: UInt8, encoder: IVE) throws -> Value
    {
        return .Leaf(.Basic(.UInt8(value)))
    }

    public static func box(_ value: UInt16, encoder: IVE) throws -> Value
    {
        return .Leaf(.Basic(.UInt16(value)))
    }

    public static func box(_ value: UInt32, encoder: IVE) throws -> Value
    {
        return .Leaf(.Basic(.UInt32(value)))
    }

    public static func box(_ value: UInt64, encoder: IVE) throws -> Value
    {
        return .Leaf(.Basic(.UInt64(value)))
    }

    public static func box(_ value: String, encoder: IVE) throws -> Value
    {
        return .Leaf(.String(value))
    }

    public static func box(_ value: Float, encoder: IVE) throws -> Value
    {
        return .Leaf(.Basic(.Float(value)))
    }

    public static func box(_ value: Double, encoder: IVE) throws -> Value
    {
        return .Leaf(.Basic(.Double(value)))
    }

    public static func boxNil(encoder: IVE) throws -> Value
    {
        return .Leaf(.Basic(.Nil))
    }

    public static func unkeyedValuesToValue(_ values: UnkeyedValues, encoder: IVE) throws -> Value
    {
        let value = ArrayValue(elements: values)
        return .Branch(.Array(value))
    }

    public static func keyedValuesToValue(_ values: KeyedValues, encoder: IVE) throws -> Value
    {
        let entries = values.map
        {
            (key: String, value: Value) in

            return DictionaryEntryValue(key: IcedValue.Leaf(.String(key)), value: value)
        }

        let value = DictionaryValue(entries: entries)
        return .Branch(.Dictionary(value))
    }
}

extension IceEncoderTransform: InternalValueSerializer
{
    public static func data(from: Value, options: IceEncoderOptions) throws -> Data
    {
        return from.data
    }
}

extension IceEncoderTransform: InternalValueStringifier
{
    public static func string(from: Value, options: IceEncoderOptions) throws -> String
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
    public typealias Value = IcedValue
    public typealias Options = IceDecoderOptions
    public typealias State = IceState

    public static var nilValue: Value = .Leaf(.Basic(.Nil))

    public static func unbox(_ value: Value, as type: Bool.Type, decoder: IVD) throws -> Bool?
    {
        switch value
        {
            case .Leaf(let leafValue):
                switch leafValue
                {
                    case .Basic(let basicValue):
                        switch basicValue
                        {
                            case .Bool(let value):
                                return value

                            default:
                                return nil
                        }

                    default:
                        return nil
                }

            default:
                return nil
        }
    }

    public static func unbox(_ value: Value, as type: Int.Type, decoder: IVD) throws -> Int?
    {
        switch value
        {
            case .Leaf(let leafValue):
                switch leafValue
                {
                    case .Basic(let basicValue):
                        switch basicValue
                        {
                            case .Int(let value):
                                return value

                            default:
                                return nil
                        }

                    default:
                        return nil
                }

            default:
                return nil
        }
    }

    public static func unbox(_ value: Value, as type: Int8.Type, decoder: IVD) throws -> Int8?
    {
        switch value
        {
            case .Leaf(let leafValue):
                switch leafValue
                {
                    case .Basic(let basicValue):
                        switch basicValue
                        {
                            case .Int8(let value):
                                return value

                            default:
                                return nil
                        }

                    default:
                        return nil
                }

            default:
                return nil
        }
    }

    public static func unbox(_ value: Value, as type: Int16.Type, decoder: IVD) throws -> Int16?
    {
        switch value
        {
            case .Leaf(let leafValue):
                switch leafValue
                {
                    case .Basic(let basicValue):
                        switch basicValue
                        {
                            case .Int16(let value):
                                return value

                            default:
                                return nil
                        }

                    default:
                        return nil
                }

            default:
                return nil
        }
    }

    public static func unbox(_ value: Value, as type: Int32.Type, decoder: IVD) throws -> Int32?
    {
        switch value
        {
            case .Leaf(let leafValue):
                switch leafValue
                {
                    case .Basic(let basicValue):
                        switch basicValue
                        {
                            case .Int32(let value):
                                return value

                            default:
                                return nil
                        }

                    default:
                        return nil
                }

            default:
                return nil
        }
    }

    public static func unbox(_ value: Value, as type: Int64.Type, decoder: IVD) throws -> Int64?
    {
        switch value
        {
            case .Leaf(let leafValue):
                switch leafValue
                {
                    case .Basic(let basicValue):
                        switch basicValue
                        {
                            case .Int64(let value):
                                return value

                            default:
                                return nil
                        }

                    default:
                        return nil
                }

            default:
                return nil
        }
    }

    public static func unbox(_ value: Value, as type: UInt.Type, decoder: IVD) throws -> UInt?
    {
        switch value
        {
            case .Leaf(let leafValue):
                switch leafValue
                {
                    case .Basic(let basicValue):
                        switch basicValue
                        {
                            case .UInt(let value):
                                return value

                            default:
                                return nil
                        }

                    default:
                        return nil
                }

            default:
                return nil
        }
    }

    public static func unbox(_ value: Value, as type: UInt8.Type, decoder: IVD) throws -> UInt8?
    {
        switch value
        {
            case .Leaf(let leafValue):
                switch leafValue
                {
                    case .Basic(let basicValue):
                        switch basicValue
                        {
                            case .UInt8(let value):
                                return value

                            default:
                                return nil
                        }

                    default:
                        return nil
                }

            default:
                return nil
        }
    }

    public static func unbox(_ value: Value, as type: UInt16.Type, decoder: IVD) throws -> UInt16?
    {
        switch value
        {
            case .Leaf(let leafValue):
                switch leafValue
                {
                    case .Basic(let basicValue):
                        switch basicValue
                        {
                            case .UInt16(let value):
                                return value

                            default:
                                return nil
                        }

                    default:
                        return nil
                }

            default:
                return nil
        }
    }

    public static func unbox(_ value: Value, as type: UInt32.Type, decoder: IVD) throws -> UInt32?
    {
        switch value
        {
            case .Leaf(let leafValue):
                switch leafValue
                {
                    case .Basic(let basicValue):
                        switch basicValue
                        {
                            case .UInt32(let value):
                                return value

                            default:
                                return nil
                        }

                    default:
                        return nil
                }

            default:
                return nil
        }
    }

    public static func unbox(_ value: Value, as type: UInt64.Type, decoder: IVD) throws -> UInt64?
    {
        switch value
        {
            case .Leaf(let leafValue):
                switch leafValue
                {
                    case .Basic(let basicValue):
                        switch basicValue
                        {
                            case .UInt64(let value):
                                return value

                            default:
                                return nil
                        }

                    default:
                        return nil
                }

            default:
                return nil
        }
    }

    public static func unbox(_ value: Value, as type: Float.Type, decoder: IVD) throws -> Float?
    {
        switch value
        {
            case .Leaf(let leafValue):
                switch leafValue
                {
                    case .Basic(let basicValue):
                        switch basicValue
                        {
                            case .Float(let value):
                                return value

                            default:
                                return nil
                        }

                    default:
                        return nil
                }

            default:
                return nil
        }
    }

    public static func unbox(_ value: Value, as type: Double.Type, decoder: IVD) throws -> Double?
    {
        switch value
        {
            case .Leaf(let leafValue):
                switch leafValue
                {
                    case .Basic(let basicValue):
                        switch basicValue
                        {
                            case .Double(let value):
                                return value

                            default:
                                return nil
                        }

                    default:
                        return nil
                }

            default:
                return nil
        }
    }

    public static func unbox(_ value: Value, as type: String.Type, decoder: IVD) throws -> String?
    {
        switch value
        {
            case .Leaf(let leafValue):
                switch leafValue
                {
                    case .String(let value):
                        return value

                    default:
                        return nil
                }

            default:
                return nil
        }
    }

    public static func valueToUnkeyedValues(_ value: Value, decoder: IVD) throws -> UnkeyedValues?
    {
        switch value
        {
            case .Branch(let containerValue):
                switch containerValue
                {
                    case .Array(let value):
                        return value.elements

                    default:
                        return nil
                }

            default:
                return nil
        }
    }

    public static func valueToKeyedValues(_ value: Value, decoder: IVD) throws -> KeyedValues?
    {
        switch value
        {
            case .Branch(let containerValue):
                switch containerValue
                {
                    case .Dictionary(let value):
                        var results = KeyedValues()
                        for entry in value.entries
                        {
                            switch entry.key
                            {
                                case .Leaf(let leafValue):
                                    switch leafValue
                                    {
                                        case .String(let key):
                                            results[key] = entry.value

                                        default:
                                            return nil
                                    }

                                default:
                                    return nil
                            }
                        }

                        return results

                    default:
                        return nil
                }

            default:
                return nil
        }
    }
}

extension IceDecoderTransform: InternalValueDeserializer
{
    public static func value(from: Data, options: IceDecoderOptions) throws -> Value
    {
        guard let result = Value(data: from) else
        {
            throw TransformsError.decodeFailure
        }

        return result
    }
}

extension IceDecoderTransform: InternalValueParser
{
    public static func value(from: String, options: IceDecoderOptions) throws -> Value
    {
        let data = from.data
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(Data.self, from: data)

        guard let result = Value(data: decoded) else
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
