//
//  WPPool.swift
//  WavePool
//
//  Created by Ryan Campbell on 11/21/15.
//  Copyright © 2015 Phalanx Studios. All rights reserved.
//

import SpriteKit

public class WPPool {
    
    public struct SpawnPoint {
        
        var point : CGPoint = CGPoint(x:0, y:0)
        
        var heading: CGFloat = 0
        
    }
    
    /// All waves for this level
    var waves : Array<WPWave>
    
    /// Index is used to determine where the spawn starts
    var spawnPoints : Array<SpawnPoint>
    
    /// Index in the wave array marking the current wave
    var currentWave : Int = 0
    
    let delegate : WPLifeguardProtocol
    
    public init(waves:Array<WPWave>, spawnPoints:Array<SpawnPoint>, delegate:WPLifeguardProtocol) {
        self.waves = waves
        self.spawnPoints = spawnPoints
        self.delegate = delegate
    }
    
    func beginWaves() {
        if currentWave < self.waves.count {
            /*Time.delay(self.waves[self.currentWave].delayTime, closure: { [weak self] in
                if let this = self {
                    this.spawnCurrentWave()
                }
                })*/
        }
        else {
            // waves finished
        }
    }
    
    func spawnCurrentWave() {
        for spawn in self.waves[self.currentWave].spawns {
            self.delegate.handleSpawn(spawn)
        }
        self.currentWave += 1
        self.delegate.waveDidStart(self.waves[self.currentWave])
        self.beginWaves()
    }
    
    func isLastWave() -> Bool {
        if(self.currentWave == self.waves.count) {
            return true
        }
        else {
            return false
        }
    }
    
}
