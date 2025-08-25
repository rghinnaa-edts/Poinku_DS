# Ribbon
The `Ribbon` component is a customizable view that displays a triangular ribbon-like element with a text label. It's designed to be used in a variety of IOS applications, especially for visual accents like banners or labels. The component supports different styles, colors, and gravity (alignment) settings, allowing for flexible usage in different UI layouts.

## Features
- Customizable text, colors, and gradients
-  Supports two types of horizontal gravity: `START` and `END` for horizontal positioning
-  Supports three types of Vertical gravity: `TOP`, `CENTER` and `BOTTOM` for vertical positioning
-  Option to adjust the text appearance with a custom style
-  Provides an option to attach/anchor to a specific view in the layout

## Ribbon Types Overview
| Ribbon Gravity    | Preview                                  |
|-------------------|------------------------------------------|
| **Start Gravity** | ![Start](https://res.cloudinary.com/dr6cm6n5f/image/upload/v1739953935/Poinku-DS-UIKit/ewlyc4vwldfd1ggnprma.png) |
| **End Gravity**   | ![End](https://res.cloudinary.com/dr6cm6n5f/image/upload/v1739953957/Poinku-DS-UIKit/o16sp9cgheg0l9x51lb8.png)   |

## Installation
To use the `Ribbon` component, please add this line code to create the form of ribbon.

### Programmatic Usage
```Gradient Color
//Gradient Color

let ribbonView = RibbonView()
ribbonView.ribbonText = "Hot Product!"
ribbonView.triangleColor = .red50
ribbonView.containerStartColor = .red20
ribbonView.containerEndColor = .red50
ribbonView.textColor = .white
ribbonView.gravity = .start

ribbonView.anchorToView(
  rootParent: parentView,
  targetView: view,
  verticalAlignment: .center
)
```

```Solid Color
// Solid Color

let ribbonView = RibbonView()
ribbonView.ribbonText = "x2"
ribbonView.triangleColor = .blue50
ribbonView.containerColor = .blue30
ribbonView.textColor = .white
ribbonView.gravity = .start

ribbonView.anchorToView(
  rootParent: parentView,
  targetView: view
)
```

## Attributes

| Attribute               | Description                                             | Default Value                             |
|-------------------------|---------------------------------------------------------|-------------------------------------------|
| `triangleColor`         | Color of the triangle at the start or end of the ribbon | `UIColor.blue50.cgColor`                  |
| `containerColor`        | Color of the ribbon's container background              | `UIColor.blue30.cgColor`                  |
| `containerStartColor`   | Starting color for gradient background of the container | `UIColor.clear`                           |
| `containerEndColor`     | Ending color for gradient background of the container   | `UIColor.clear`                           |
| `textColor`             | Color of the ribbon's text                              | `UIColor.white.cgColor`                   |
| `gravity`               | Gravity to position the ribbon: `START` or `END`        | `START`                                   |
| `ribbonText`            | Text displayed inside the ribbon                        | Empty string                              |
| `cornerRadius`          | Radius for rounded corners of the container             | `2`                                       |
| `textVerticalPadding`   | Padding above and below the text                        | `4`                                       |
| `textHorizontalPadding` | Padding to the left and right of the text               | `4`                                       |

## Methods
`anchorToView(rootParent: ViewGroup, targetView: View, verticalAlignment: VerticalAlignment, offsetX: Int, offsetY: Int)`

Anchors the `Ribbon` to a specific `targetView` and positions it relative to that view.

#### Parameters:

-   `rootParent`: The parent `ViewGroup` to attach the ribbon to.
-   `targetView`: The view the ribbon will be anchored to.
-   `verticalAlignment`: Determines the vertical alignment (Top, Center, Bottom).
-   `offsetX`: Horizontal offset for positioning.
-   `offsetY`: Vertical offset for positioning.

## Customization

You can customize various properties of the `Ribbon` component to match your design needs, including the text, colors, corner radius, padding, and more.

To further customize the behavior of the `Ribbon`, you can modify the `gravity`, container colors, or triangle positioning. For example, use `gravity` to align the ribbon to the left (`START`) or right (`END`) of the target view.

## Performance Considerations

The `Ribbon` component uses custom drawing with `Path` and `Paint` objects to render its shape and text. If you're using it in a complex layout or RecyclerView, ensure that the component is efficiently managed to avoid unnecessary re-rendering, especially if it's dynamically added and removed from the view hierarchy.

* * *

For further customization or to extend this component, you can ask UX Engineer or Inherit the `Ribbon` and override its methods or add additional functionality as requi
