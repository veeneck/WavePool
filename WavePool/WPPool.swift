//
//  WPPool.swift
//  WavePool
//
//  Created by Ryan Campbell on 11/21/15.
//  Copyright © 2015 Phalanx Studios. All rights reserved.
//

import SpriteKit

/**
    Class to manage the timing of waves, and calling a WPLifeguardProtocol delegate during key events.
*/
public class WPPool {
    
    /// A coordinate to indicate where a WPSpawn should take place. Loaded once, and then referenced as index.
    public struct SpawnPoint {
        
        /// Point on a map.
        public var point : CGPoint = CGPoint(x:0, y:0)
        
        /// Direction to face when spawning at this point.
        public var heading: CGFloat = 0
        
        public init() {
            
        }
        
    }
    
    /// All waves for this level
    private var waves : Array<WPWave>!
    
    /// Index is used to determine where the spawn starts
    public var spawnPoints : Array<SpawnPoint>
    
    /// Index in the wave array marking the current wave
    private var currentWave : Int = 0
    
    /// Delegate to handle callbacks related to key spawn and wave events
    private let delegate : WPLifeguardProtocol
    
    /// Elapsed time since last wave
    private var elapsedTime : NSTimeInterval = 0.0
    
    private var running : Bool = false
    
    // MARK: Initializing a Pool
    
    /**
    Construction for the WPPool.
     
    - parameter fileName: The name of the pList file. Must exist or it will hard error.
    - parameter spawnPoints: An array of spawn points that cooresponds to indexes in the pList
    - parameter delegate: The class that will handle key event callbacks
     
    - warning: Assume the pList exists and is properly constructed.
    */
    public init(fileName:String, spawnPoints:Array<SpawnPoint>, delegate:WPLifeguardProtocol) {
        self.spawnPoints = spawnPoints
        self.delegate = delegate
        self.waves = self.initFromPlist(fileName)
    }
    
    // MARK: Managing Waves
    
    /**
    Call this once when you are ready to start the pool.
    
    - warning: No saftey check for multiple calls.
    */
    public func beginWaves() {
        self.running = true
    }
    
    /// This will pause the timer. When resuming, the timer will pick up at the point it was stopped.
    public func pause() {
        self.running = false
    }
    
    /// Internal func to trigger the delegate to handle a spawn, and advance the currentSpawn counter.
    private func spawnCurrentWave() {
        for spawn in self.waves[self.currentWave].spawns {
            self.delegate.handleSpawn(spawn)
        }
        self.delegate.waveDidStart(self.waves[self.currentWave])
        self.currentWave += 1
    }
    
    /// Lookup to determine when the last wave is reached. This is useful because a delegate callback when the waves are finished isn't enough to determine an event like level completed. Instead, the user would wait until the last enemy dies and then check with the WPPool to make sure no more enemies are coming. This function will assist with that.
    public func isLastWave() -> Bool {
        if(self.currentWave == self.waves.count) {
            return true
        }
        else {
            return false
        }
    }
    
    // MARK: Update Loop
    
    /**
    Must be called for WPPool to function. Preferably, call every frame within your game loop.
    
    - parameter seconds: The delta time so that time elapsed can be tracked.
    */
    public func updateWithDeltaTime(seconds: NSTimeInterval) {
        if self.running && self.currentWave < self.waves.count {
            self.elapsedTime += seconds
            let currentWave = self.waves[self.currentWave]
            
            /// Time for a wave if wait time exceeded
            if currentWave.delayTime <= self.elapsedTime {
                self.elapsedTime = 0.0
                self.spawnCurrentWave()
            }
        }
    }
    
    // MARK: Factory Constrution
    
    /// Load pList and call helper functions
    private func initFromPlist(name:String) -> [WPWave] {
        let path = NSBundle.mainBundle().pathForResource(name, ofType: "plist")
        let pListData = NSDictionary(contentsOfFile:path!)!
        let waveData = pListData.objectForKey("Waves") as! NSArray
        return self.createWavesFromNSArray(waveData)
    }
    
    /// Loop trhough each wave in the pList and build it.
    private func createWavesFromNSArray(data:NSArray) -> [WPWave] {
        var waves = [WPWave]()
        
        for waveData in data {
            var wave = WPWave()
            if let delayTime = waveData.objectForKey("DelayTime") as? Double,
                waitTime = waveData.objectForKey("WaitTime") as? Double,
                spawns = waveData.objectForKey("spawns") as? Array<NSDictionary> {
                    wave.delayTime = delayTime
                    wave.waitTime = waitTime
                    wave.spawns = self.createSpawnsFromArray(spawns)
                    waves.append(wave)
            }
        }
        
        return waves
    }
    
    /// Loop through each spawn in a wave.
    private func createSpawnsFromArray(data:Array<NSDictionary>) -> [WPSpawn] {
        var spawns = [WPSpawn]()
        
        for spawnData in data {
            var spawn = WPSpawn()
            
            if let enemy = spawnData.objectForKey("Enemy") as? String,
                amount = spawnData.objectForKey("Amount") as? Int,
                spacing = spawnData.objectForKey("Spacing") as? Int,
                columns = spawnData.objectForKey("Columns") as? Int,
                waitTime = spawnData.objectForKey("WaitTime") as? Double,
                path = spawnData.objectForKey("Path") as? Int {
                    spawn.enemy = enemy
                    spawn.amount = amount
                    spawn.spacing = spacing
                    spawn.columns = columns
                    spawn.waitTime = waitTime
                    spawn.path = path
                    
                    spawns.append(spawn)
            }
            
        }
        
        return spawns
    }
    
}
