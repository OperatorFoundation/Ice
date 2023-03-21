//
//  Options.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/21/23.
//

import Foundation

import PotentCodables

public struct IceEncoderOptions: InternalEncoderOptions
{
    public var keyEncodingStrategy: PotentCodables.KeyEncodingStrategy = .useDefaultKeys
    public var userInfo: [CodingUserInfoKey: Any] = [:]
}

public struct IceDecoderOptions: InternalDecoderOptions
{
    public var keyDecodingStrategy: PotentCodables.KeyDecodingStrategy = .useDefaultKeys
    public var userInfo: [CodingUserInfoKey: Any] = [:]
}
