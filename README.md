# WavePool

Simple tool to manage waves of spawns (i.e.: TowerDefense) in SpriteKit. Goals are:

- Read from pList
- Call delegate to handle the actual spawn
- Keep track of time and cleanup
- Allow pausing
- Allow predconditions through willSpawn delegate

## Example

Example code to set up the pool.

```swift
var spawnA = WPPool.SpawnPoint()
spawnA.point = CGPoint(x:1050, y:1100)
spawnA.heading = 4.5

var spawnB = WPPool.SpawnPoint()
spawnB.point = CGPoint(x:1500, y:460)
spawnB.heading = 3


self.wavePool = WPPool(fileName: "Sample", spawnPoints: [spawnA, spawnB], delegate: self)
self.wavePool.beginWaves()
```

The `fileName` above refers to the pList config file. See the [sample file](https://github.com/veeneck/WavePool/blob/master/sample.plist) for an example of how to configure the data.

From there, just set up a class in your own project that conforms to `WPLifeguardProtocol` and everything will work.

## Status

In progress.

The WPSpawn object is tailored to my games, but the rest is fairly generic. If you're looking at how you could use this, start with `WPPool` as that could work for any code base. The only portion that is specific to me is `WPSpawn`, and that could be easily modified to suit variables you need.

## Documentation

Docs are located at [veeneck.github.io/WavePool](http://veeneck.github.io/WavePool) and are generated with [Jazzy](https://github.com/Realm/jazzy). The config file for the documentation is in the project as `config.yml`. Docs can be generated by running this command **in** the project directory:

jazzy --config {PATH_TO_REPOSITORY}/WavePool/WavePool/config.yml

**Note**: The output in the `config.yml` is hard coded to one computer. Edit the file and update the `output` flag to a valid location.
