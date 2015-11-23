//
//  WPWave.swift
//  WavePool
//
//  Created by Ryan Campbell on 11/21/15.
//  Copyright © 2015 Phalanx Studios. All rights reserved.
//

import SpriteKit

/**
Container representing one wave in the pool. A wave can contain many spawns. There can be a delay between waves.
*/
public struct WPWave {
    
    /// Figure this out. Currently does nothing.
    var waitTime : Double = 0
    
    /// How long to wait since the last wave to process.
    var delayTime : Double = 0
    
    /// WPSpawn associated with this wave.
    var spawns = Array<WPSpawn>()
    
}
