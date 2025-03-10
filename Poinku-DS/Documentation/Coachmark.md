# Coachmark
The `Coachmark` component is a visual overlay element that helps guide users through the app's features and functionality.

## Features
-  Customizable text title, description, spotlight radius, button color
-  Option to adjust the text appearance with a custom style
-  Provides step-by-step coachmark by using Arrays
-  Provides an option to attach/anchor to a specific view in the layout

## Preview
![Coachmark Preview](https://res.cloudinary.com/dr6cm6n5f/image/upload/c_scale,w_300/v1741336737/WhatsApp_GIF_2025-03-07_at_14.50.56_mxtwms.gif)

## Methods
- `configure(title: String, description: String, targetView: UIView, spotlightRadius: CGFloat, tintColor: UIView)`
- `configureSteps(steps: [Coachmark.StepConfiguration])`
  `Coachmark.StepConfiguration(title: String, description: String, targetView: UIView, spotlightRadius: CGFloat, tintColor: UIView)`

#### Parameters:
| Parameters              | Description                                             | Default Value                             |
|-------------------------|---------------------------------------------------------|-------------------------------------------|
| `title`                 | Title of the coachmark                                  | `required`                                |
| `description`           | Description of the coachmark                            | `required`                                |
| `targetView`            | Relative view for coachmark's spotlight anchor          | `required`                                |
| `spotlightRadius`       | Radius of coachmark's spotlight                         | `8`                                       |
| `tintColor`             | Color of the button                                     | `UIColor.blue30`                          |

## Installation
To use the `Coachmark` component, please follow this step.
For now, It's available only when you add the coachmark class file of swift and XIB into your project
- Add file Coachmark.swift and Coachmark.XIB into your project

### Usage
```Example Show One Step
  let coachmark = Coachmark(frame: view.bounds)
        
  coachmark.configure(
    title: "Add New Item",
    description: "Tap this button to add a new item to your list",
    targetView: btnAdd
  )
        
  coachmark.show()
```

```Example Show More Than One Step
  let coachmark = Coachmark(frame: view.bounds)
        
  coachmark.configureSteps(steps: [
      Coachmark.StepConfiguration(
        title: "Show Title",
        description: "This is the title of the context"
        targetView: lblTitle
      ),
      Coachmark.StepConfiguration(
        title: "Show Description",
        description: "This is the description of the context",
        targetView: lblDescription
      ),
      Coachmark.StepConfiguration(
        title: "Submit Description",
        description: "Tap this button to submit your description",
        targetView: btnSubmit
      ),
  ])
        
  coachmark.show()
```
* * *

For further customization or to extend this component, you can ask UX Engineer or Inherit the `Coachmark` and override its methods or add additional functionality as required.
