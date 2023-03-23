////
////  IceEncoder.swift
////  
////
////  Created by Dr. Brandon Wiley on 3/12/23.
////
//
//import Foundation
//
//public class IceEncoder: Encoder
//{
//    public var codingPath: [CodingKey] = []
//    public var userInfo: [CodingUserInfoKey : Any] = [:]
//
//    public var value: IcedValue? = nil
//
//    public init()
//    {
//    }
//
//    public func encode(_ value: Encodable) throws -> IcedValue
//    {
//        try value.encode(to: self)
//
//        guard let value = self.value else
//        {
//            throw IceEncoderError.nilValue
//        }
//
//        return value
//    }
//
//    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey
//    {
//        return KeyedEncodingContainer(IceKeyedEncodingContainer(encoder: self, codingPath: self.codingPath, keyedBy: type))
//    }
//
//    public func unkeyedContainer() -> UnkeyedEncodingContainer
//    {
//        return IceUnkeyedEncodingContainer(encoder: self, codingPath: self.codingPath)
//    }
//
//    public func singleValueContainer() -> SingleValueEncodingContainer
//    {
//        return IceSingletonEncodingContainer(encoder: self, codingPath: self.codingPath)
//    }
//}
//
//public enum IceEncoderError: Error
//{
//    case nilValue
//}
