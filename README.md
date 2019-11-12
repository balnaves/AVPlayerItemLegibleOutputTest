# AVPlayerItemLegibleOutputTest
This is a simple test project to get callbacks of caption changes in an HLS live stream.
Uses `AVPlayerItemLegibleOutput` and `AVPlayerItemLegibleOutputPushDelegate`.

The key steps to making this work are:
1. Create an output: `let captionOutput = AVPlayerItemLegibleOutput()`.
2. Set ourselves as a delegate: `captionOutput.setDelegate(self, queue: DispatchQueue.main)`.
3. When the stream is ready, add the output: `player.currentItem?.add(captionOutput)`.
4. Create a delegate extension to get the caption changes:
```swift
extension ViewController: AVPlayerItemLegibleOutputPushDelegate {
    func legibleOutput(_ output: AVPlayerItemLegibleOutput,
                       didOutputAttributedStrings strings: [NSAttributedString],
                       nativeSampleBuffers nativeSamples: [Any],
                       forItemTime itemTime: CMTime) {
        // Your attributed caption strings get delivered here!
    }
}
```
5. Optionally, supress captions on the player: `captionOutput.suppressesPlayerRendering = true`.
