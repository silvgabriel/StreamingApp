# StreamingApp

A simple project that uses an API to list mocked episodes and play their respective videos.

https://github.com/user-attachments/assets/ac84184a-7161-4634-b63c-17954a5b6c72

## Considerations
### Assumptions or limitations
For this project I ended up leaving SwiftUI's VideoPlayer, but it is still a component with some limitations, such as the option to watch the video in full screen, which does not yet exist. A solution for this would be to create a custom player using AVPlayerViewController and insert it into SwiftUI with UIViewControllerRepresentable. Or use an external player from the market and customize it.

### Description of the problems if you faced some.
No problems other than the VideoPlayer limitation I mentioned above.

### Your reasoning behind the chosen architecture.
I have experience using MVVM in small and large applications and, in my opinion, it has always worked very well, allowing us to create clean, organized and scalable code.

The learning curve is short and suits all developers regardless of level and it is an architecture that works very similarly in both UIKit and SwiftUI, allowing us to use both frameworks at the same time.

### Requirements
iOS 18+

Developed using iPhone 15 Pro with iOS 18.4 and Xcode 16.3
