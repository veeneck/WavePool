//
//  WPLifeguardProtocol.swift
//  WavePool
//
//  Created by Ryan Campbell on 11/21/15.
//  Copyright © 2015 Phalanx Studios. All rights reserved.
//

import SpriteKit

/**
Protocol to handle key events of each wave.
*/
public protocol WPLifeguardProtocol {
    
    /// Just before the wave starts. This is a chance to run logic and pause the WPPool.
    func waveWillStart(wave:WPWave)
    
    /// Wave has already spawned. A chance to cancel the next wave early, or perform post logic.
    func waveDidStart(wave:WPWave)
    
    /// Callback to indicate the spawn should be added to the world.
    func handleSpawn(spawn:WPSpawn)
    
}
