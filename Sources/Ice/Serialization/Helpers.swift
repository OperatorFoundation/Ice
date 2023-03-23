//
//  Helpers.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/22/23.
//

import Foundation

public func dictionary(data: Data) -> DictionaryValue?
{
    return DictionaryValue(data: data)
}

public func structValue(data: Data) -> StructValue?
{
    return StructValue(data: data)
}

public func classValue(data: Data) -> ClassValue?
{
    return ClassValue(data: data)
}

public func array(data: Data) -> ArrayValue?
{
    return ArrayValue(data: data)
}

public func data(array: ArrayValue) -> Data
{
    return array.data
}

public func data(basic: BasicValue) -> Data
{
    return basic.data
}

public func basic(data: Data) -> BasicValue?
{
    return BasicValue(data: data)
}

public func data(iced: IcedValue) -> Data
{
    return iced.data
}

public func iced(data: Data) -> IcedValue?
{
    return IcedValue(data: data)
}

func dataToFloat(_ data: Data) -> Float?
{
    guard data.count == 4 else
    {
        return nil
    }

    return Float(data: data)
}

func dataToDouble(_ data: Data) -> Double?
{
    guard data.count == 8 else
    {
        return nil
    }

    return Double(data: data)
}


func dataToUInt8(_ data: Data) -> UInt8?
{
    guard data.count == 1 else
    {
        return nil
    }

    return UInt8(data: data)
}

func dataToUInt16(_ data: Data) -> UInt16?
{
    guard data.count == 2 else
    {
        return nil
    }

    return UInt16(data: data)
}

func dataToUInt32(_ data: Data) -> UInt32?
{
    guard data.count == 4 else
    {
        return nil
    }

    return UInt32(data: data)
}

func dataToUInt64(_ data: Data) -> UInt64?
{
    guard data.count == 8 else
    {
        return nil
    }

    return UInt64(data: data)
}

func dataToInt8(_ data: Data) -> Int8?
{
    guard data.count == 1 else
    {
        return nil
    }

    return Int8(data: data)
}

func dataToInt16(_ data: Data) -> Int16?
{
    guard data.count == 2 else
    {
        return nil
    }

    return Int16(data: data)
}

func dataToInt32(_ data: Data) -> Int32?
{
    guard data.count == 4 else
    {
        return nil
    }

    return Int32(data: data)
}

func dataToInt64(_ data: Data) -> Int64?
{
    guard data.count == 8 else
    {
        return nil
    }

    return Int64(data: data)
}


func uintToUInt64(_ uint: UInt) -> UInt64
{
    return UInt64(uint)
}

func intToInt64(_ int: Int) -> Int64
{
    return Int64(int)
}

func uint64ToUInt(_ uint64: UInt64) -> UInt
{
    return UInt(uint64)
}

func int64ToInt(_ int64: Int64) -> Int
{
    return Int(int64)
}
