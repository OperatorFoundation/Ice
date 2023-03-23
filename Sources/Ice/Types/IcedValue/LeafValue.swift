//
//  LeafValue.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/22/23.
//

import Foundation

import Datable
import PotentCodables

public enum LeafValue: Codable
{
    case Basic(BasicValue)
    case String(String)
}

extension LeafValue: Value
{
    public var isNull: Bool
    {
        switch self
        {
            case .Basic(let value):
                return value.isNull

            case .String(_):
                return false
        }
    }

    public var unwrapped: Any?
    {
        switch self
        {
            case .Basic(let value):
                return value.unwrapped

            case .String(let value):
                return value
        }
    }
}
