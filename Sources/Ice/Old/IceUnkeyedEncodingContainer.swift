////
////  IceUnkeyedEncodingContainer.swift
////  
////
////  Created by Dr. Brandon Wiley on 3/12/23.
////
//
//import Foundation
//
//public class IceUnkeyedEncodingContainer: UnkeyedEncodingContainer
//{
//    public var count: Int = 0
//    public var codingPath: [CodingKey]
//
//    let encoder: IceEncoder
//
//    public init(encoder: IceEncoder, codingPath: [CodingKey])
//    {
//        self.encoder = encoder
//        self.codingPath = codingPath
//    }
//
//    public func encodeNil() throws
//    {
//        try self.set(.Leaf(.Basic(.Nil)), index: self.count)
//    }
//
//    public func encode(_ value: Bool) throws
//    {
//        try self.set(.Leaf(.Basic(.Bool(value))), index: self.count)
//    }
//
//    public func encode(_ value: String) throws
//    {
//        try self.set(.Leaf(.String(value)), index: self.count)
//    }
//
//    public func encode(_ value: Double) throws
//    {
//        try self.set(.Leaf(.Basic(.Double(value))), index: self.count)
//    }
//
//    public func encode(_ value: Float) throws
//    {
//        try self.set(.Leaf(.Basic(.Float(value))), index: self.count)
//    }
//
//    public func encode(_ value: Int) throws
//    {
//        try self.set(.Leaf(.Basic(.Int(value))), index: self.count)
//    }
//
//    public func encode(_ value: Int8) throws
//    {
//        try self.set(.Leaf(.Basic(.Int8(value))), index: self.count)
//    }
//
//    public func encode(_ value: Int16) throws
//    {
//        try self.set(.Leaf(.Basic(.Int16(value))), index: self.count)
//    }
//
//    public func encode(_ value: Int32) throws
//    {
//        try self.set(.Leaf(.Basic(.Int32(value))), index: self.count)
//    }
//
//    public func encode(_ value: Int64) throws
//    {
//        try self.set(.Leaf(.Basic(.Int64(value))), index: self.count)
//    }
//
//    public func encode(_ value: UInt) throws
//    {
//        try self.set(.Leaf(.Basic(.UInt(value))), index: self.count)
//    }
//
//    public func encode(_ value: UInt8) throws
//    {
//        try self.set(.Leaf(.Basic(.UInt8(value))), index: self.count)
//    }
//
//    public func encode(_ value: UInt16) throws
//    {
//        try self.set(.Leaf(.Basic(.UInt16(value))), index: self.count)
//    }
//
//    public func encode(_ value: UInt32) throws
//    {
//        try self.set(.Leaf(.Basic(.UInt32(value))), index: self.count)
//    }
//
//    public func encode(_ value: UInt64) throws
//    {
//        try self.set(.Leaf(.Basic(.UInt64(value))), index: self.count)
//    }
//
//    public func encode<T>(_ value: T) throws where T : Encodable
//    {
//        throw IceKeyedEncodingContainerError.unimplemented // FIXME - how?
//    }
//
//    public func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey
//    {
//        let key = ArrayCodingKey(intValue: self.count)! // Sorry, we have to force unwrap because there is no way for this function to fail.
//        let container = IceKeyedEncodingContainer<NestedKey>(encoder: self.encoder, codingPath: self.codingPath + [key], keyedBy: keyType)
//        return KeyedEncodingContainer<NestedKey>(container)
//    }
//
//    public func nestedUnkeyedContainer() -> UnkeyedEncodingContainer
//    {
//        let key = ArrayCodingKey(intValue: self.count)! // Sorry, we have to force unwrap because there is no way for this function to fail.
//        let path = self.codingPath + [key]
//        return IceUnkeyedEncodingContainer(encoder: self.encoder, codingPath: path)
//    }
//
//    public func superEncoder() -> Encoder
//    {
//        return self.encoder
//    }
//
//    func set(_ value: IcedValue, index: Int) throws
//    {
//        if let container = self.encoder.value
//        {
//            switch container
//            {
//                case .Leaf(_):
//                    throw IceSingletonEncodingContainerError.incompatibleEncoderValue(container)
//
//                case .Branch(_):
//                    self.encoder.value = try put(container: container, path: self.codingPath, value: value)
//                    self.count += 1
//            }
//        }
//        else
//        {
//            if self.codingPath.isEmpty
//            {
//                self.encoder.value = value
//                self.count += 1
//            }
//            else
//            {
//                throw IceSingletonEncodingContainerError.badCodingPath(self.codingPath)
//            }
//        }
//    }
//}
//
//public enum IceUnkeyedEncodingContainerError: Error
//{
//    case unimplemented
//}
