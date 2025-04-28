# OnBoarding
The `OnBoarding` component is a series of screens or steps that introduce new users to an application, product, or service when they first sign up or start using it.

## Features
-  Customizable title, description, image

## Preview
![OnBoarding Preview](https://res.cloudinary.com/dr6cm6n5f/image/upload/c_scale,w_300/v1745818109/WhatsApp_GIF_2025-04-28_at_12.27.44_nlgmkt.gif)

## Class
- struct OnBoardingSlides = image: UIImage, title: String, description: String

#### Parameters:
| Parameters              | Description                                             | Default Value                             |
|-------------------------|---------------------------------------------------------|-------------------------------------------|
| `slides`                | List of OnBoardingSlide (title, desc, image)            | `required`                                |

## Installation
To use the `OnBoarding` component, please follow this step.
For now, It's available only when you add all the OnBoarding class file of swift and XIB into your project. It placed at `Poinku-DS/Component/View/OnBoarding`
- Add file OnBoarding.swift into your project //onBoarding Component
- Add file OnBoarding.xib into your project //onBoarding Component
- Add file OnBoardingCell.swift into your project //onBoardingCell Component
- Add file OnBoardingCell.xib into your project //onBoardingCell Component
- Add file OnBoardingSlide.swift into your project //onBoarding Model Class
- Add file CustomPageControl into your project // Custom Page Control
- Add OnBoarding assets (image onboarding, onboarding2, onboardig3)
- Create a UIView in your View Controller storyboard and direct it class to OnBoarding.swift
- Add the IBOutlet of OnBoarding UIView into your View Controller
- Add the `Usage Step`
- Add the edge to edge UI for seamless the system bar

### Usage
```Example OnBoarding
  private func setupSlides() {
    onBoarding.slides = [
            OnBoardingSlide(
                image: UIImage(named: "onboarding"),
                title: "Kumpulkan Poin dan Stamp Buat Dapetin Kejutan!",
                description: "Kumpulkan poin serta stamp dari setiap transaksi dan tukarkan dengan kupon menarik di sini!"),
            OnBoardingSlide(
                image: UIImage(named: "onboarding2"),
                title: "Dapetin Diskon, Bonus, Sampai Gratisan!",
                description: "Jangan lupa untuk gunakan kupon untuk mendapatkan banyak keuntungan!"),
            OnBoardingSlide(
                image: UIImage(named: "onboarding3"),
                title: "Semakin Sering Belanja, Semakin Untung!",
                description: "Makin sering kamu belanja semakin banyak bonus, serta diskon yang bisa kamu dapetin.")
        ]
    }
```

### FULL CODE EXAMPLE
You can see the example of implementation at `Poinku-DS/Component/ViewController/OnBoarding/OnBoardingViewController.swift`

* * *

For further customization or to extend this component, you can ask UX Engineer or Inherit the `OnBoarding` and override its methods or add additional functionality as required.
