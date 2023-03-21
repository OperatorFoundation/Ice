//
//  Coder.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/21/23.
//

import Foundation

import PotentCodables

public class IceEncoder: ValueEncoder<BasicValue, IceEncoderTransform>
{
    public override var options: IceEncoderOptions
    {
        return IceEncoderOptions()
    }
}

public class IceDecoder: ValueDecoder<BasicValue, IceDecoderTransform>
{
    public override var options: IceDecoderOptions
    {
        return IceDecoderOptions()
    }
}

