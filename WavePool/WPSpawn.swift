//
//  WPSpawn.swift
//  WavePool
//
//  Created by Ryan Campbell on 11/21/15.
//  Copyright © 2015 Phalanx Studios. All rights reserved.
//

import SpriteKit

/**
Container to hold information about the spawn. A spawn represents one object in a wave. A wave may contain many spawns. Specific to my game, a spawn is a Squad. The pList data will match up to the variable sin this struct.
*/
public struct WPSpawn {
    
    /// The name of the enemy to spawn. Assume name is a unique string that represents the ID of the squad.
    public var enemy : String = ""
    
    /// How many units to add to the squad.
    public var amount : Int = 0
    
    /// How far apart each unit should be space.
    public var spacing : Int = 0
    
    /// How many columns make up the formation.
    public var columns : Int = 0
    
    /// From when the wave starts, how long shoud this spawn wait to process.
    public var waitTime : Double = 0
    
    /// Index of WPSpawnPoint to use from current WPWavePool.
    // TODO: This should be an actual point object
    public var path : Int = 0
    
}