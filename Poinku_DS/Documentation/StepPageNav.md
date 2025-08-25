# Step Page Navigation
The `Step Page Navigation` component is a step navigation to show timeline of what have to do in 3 steps.

## Features
-  Customizable title
-  Set current page (3 pages)

## Preview
![StepPageNav Preview](https://res.cloudinary.com/dr6cm6n5f/image/upload/c_scale,w_300/v1750737061/Step_Page_Navigation_gpwfuk.gif)


#### Parameters:
| Parameters              | Description                                             | Default Value                             |
|-------------------------|---------------------------------------------------------|-------------------------------------------|
| `title`                | List of Title with type String                           | `required`                                |
| `currentStep`          | Current step to start animation                          | `required`                                |

## Installation
To use the `Step Page Navigation` component, please follow this step.
For now, It's available only when you add Step Page Nav class file of swift and XIB into your project. It placed at `Poinku-DS/Component/View/StepPageNav`
- Add file StepPageNav.swift into your project
- Add file StepPageNav.xib into your project
- Create a UIView in your View Controller storyboard with height 16 and direct it class to StepPageNav.swift
- Add the IBOutlet of StepPageNav UIView into your View Controller
- Add the `Usage Step`

### Usage
```swift
    @IBOutlet var vStep: StepPageNav!

    private func setupStep() {
        vStep.title = ["Isi Data Diri", "Verifikasi", "Buat PIN"]
        vStep.currentStep = 1 //fill with current page number [1, 2, 3]
    }
```

### FULL CODE EXAMPLE
You can see the example of implementation at `Poinku-DS/Component/ViewController/RegisterPage/Register1ViewController.swift`

* * *

For further customization or to extend this component, you can ask UX Engineer or Inherit the `Step Page Navigation` and override its methods or add additional functionality as requi
