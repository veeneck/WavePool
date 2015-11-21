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
    
    /// How long to wait since the last wave to process.
    var waitTime : Double = 0
    
    /// Figure this out. Currently does nothing.
    var delayTime : Double = 0
    
    /// WPSpawn associated with this wave.
    var spawns = Array<WPSpawn>()
    
}
