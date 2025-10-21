# SectionView

A Swift package providing customizable UI components for iOS applications, including headline containers, scrollable images with zoom effects, and gradient borders.

## Requirements

- iOS 15.0+
- macOS 12.0+
- Swift 6.0+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "(https://github.com/mirak2pk/HeadlineKit)", from: "1.0.0")
]
```

Or in Xcode:
1. File > Add Packages...
2. Enter the repository URL
3. Choose your version constraints
4. Click "Add Package"

## Features

### SectionView

A container view that displays a title with optional action button and content. Supports rounded background style.

```swift
HeadlineContainer(
    title: "My Title",
    actionTitle: "See All",
    roundedBgr: .background
) {
    // Your content here
} action: {
    // Action when button is tapped
}
```

#### Customization Options:
- `title`: Main title text
- `actionTitle`: Optional button text (if empty, no button shown)
- `roundedBgr`: Choose between `.background` or `.none`
- Custom content using ViewBuilder
- Custom action closure

### UpScrollResizeImage

A view that displays an image with a zoom effect when scrolling up.

```swift
UpScrollResizeImage(
    url: "https://example.com/image.jpg",
    height: 300
)
```

#### Features:
- Automatic image loading with loading indicator
- Fallback images for failed loads
- Smooth scroll-based scaling animation
- Rounded corners
- SDWebImage integration for efficient image loading

### Gradient Border

Add a customizable gradient border to any view.

```swift
Text("Hello")
    .gradientStroke(
        radius: 25,
        colors: [.blue.opacity(0.7), .green.opacity(0.1)],
        lineWidth: 1,
        blurRadius: 1
    )
```

#### Customization Options:
- `radius`: Corner radius
- `colors`: Gradient colors array
- `lineWidth`: Border width
- `blurRadius`: Border blur effect

## Usage Examples

### Complete Example

```swift
import SwiftUI
import HeadlineContainer

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Headline container with background
                HeadlineContainer(
                    title: "Featured",
                    actionTitle: "See All",
                    roundedBgr: .background
                ) {
                    // Content
                    Text("Featured content here")
                } action: {
                    print("See all tapped")
                }
                
                // Image with scroll effect
                UpScrollResizeImage(
                    url: "https://example.com/image.jpg",
                    height: 200
                )
                
                // Text with gradient border
                Text("Hello, World!")
                    .padding()
                    .gradientStroke(
                        colors: [.blue.opacity(0.7), .purple.opacity(0.1)]
                    )
            }
        }
    }
}
```

## Best Practices

1. HeadlineContainer:
   - Use `.background` style for featured sections
   - Use `.none` for regular section headers
   - Keep titles concise

2. UpScrollResizeImage:
   - Use appropriate image height for your layout
   - Consider screen size when setting dimensions
   - Provide quality images for better scaling

3. Gradient Border:
   - Use subtle opacity values for elegant borders
   - Match colors with your app's theme
   - Adjust blur for desired effect

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Support

For questions and support, please [create an issue](https://github.com/mirak2pk/HeadlineKit/issues) in the repository.
