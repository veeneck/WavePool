//
//  WPLifeguardProtocol.swift
//  WavePool
//
//  Created by Ryan Campbell on 11/21/15.
//  Copyright © 2015 Phalanx Studios. All rights reserved.
//

import SpriteKit

public protocol WPLifeguardProtocol {
    
    func waveWillStart(wave:WPWave)
    
    func waveDidStart(wave:WPWave)
    
    func handleSpawn(spawn:WPSpawn)
    
}
