import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class GradientPallete {
  GradientPallete({this.name, this.gradient, this.shaddowcolor});
  final String name;
  final LinearGradient gradient;
  final Color shaddowcolor; // titles for indices > threshold are white, otherwise black
  bool get isValid => name != null && gradient != null;
}

final List<GradientPallete> allgradientPalettesval = <GradientPallete>[
  GradientPallete(
    name: 'HOTLINER', 
    gradient: Gradients.hotLinear,
    shaddowcolor: Gradients.hotLinear.colors.last.withOpacity(0.25)
    ),
  GradientPallete(
    name: 'ALI', 
    gradient: Gradients.ali,
    shaddowcolor: Gradients.ali.colors.last.withOpacity(0.25)
    ),
  GradientPallete(
    name: 'ALIHUSSIEN', 
    gradient: Gradients.aliHussien,
    shaddowcolor: Gradients.aliHussien.colors.last.withOpacity(0.25)
    ),
    GradientPallete(
    name: 'BACKTOFUTURE', 
    gradient: Gradients.backToFuture,
    shaddowcolor: Gradients.backToFuture.colors.last.withOpacity(0.25)
    ),
    GradientPallete(
    name: 'BLUSH', 
    gradient: Gradients.blush,
    shaddowcolor: Gradients.blush.colors.last.withOpacity(0.25)
    ),
    GradientPallete(
    name: 'BYDESIGN', 
    gradient: Gradients.byDesign,
    shaddowcolor: Gradients.byDesign.colors.last.withOpacity(0.25)
    ),
    GradientPallete(
    name: 'COLDLINEAR', 
    gradient: Gradients.coldLinear,
    shaddowcolor: Gradients.coldLinear.colors.last.withOpacity(0.25)
    ),
    GradientPallete(
    name: 'CORALCANDY', 
    gradient: Gradients.coralCandyGradient,
    shaddowcolor: Gradients.coralCandyGradient.colors.last.withOpacity(0.25)
    ),
    GradientPallete(
    name: 'COSMICFUSION', 
    gradient: Gradients.cosmicFusion,
    shaddowcolor: Gradients.cosmicFusion.colors.last.withOpacity(0.25)
    ),
    GradientPallete(
    name: 'DEEPSPACE', 
    gradient: Gradients.deepSpace,
    shaddowcolor: Gradients.deepSpace.colors.last.withOpacity(0.25)
    ),
    GradientPallete(
    name: 'HAZE', 
    gradient: Gradients.haze,
    shaddowcolor: Gradients.haze.colors.last.withOpacity(0.25)
    ),
    GradientPallete(
    name: 'HERSHEYS', 
    gradient: Gradients.hersheys,
    shaddowcolor: Gradients.hersheys.colors.last.withOpacity(0.25)
    ),
    GradientPallete(
    name: 'JSHINE', 
    gradient: Gradients.jShine,
    shaddowcolor: Gradients.jShine.colors.last.withOpacity(0.25)
    ),
    GradientPallete(
    name: 'RAINBOWBLUE', 
    gradient: Gradients.rainbowBlue,
    shaddowcolor: Gradients.rainbowBlue.colors.last.withOpacity(0.25)
    ),
    GradientPallete(
    name: 'SERVE', 
    gradient: Gradients.serve,
    shaddowcolor: Gradients.serve.colors.last.withOpacity(0.25)
    ),
    GradientPallete(
    name: 'TAITANUM', 
    gradient: Gradients.taitanum,
    shaddowcolor: Gradients.taitanum.colors.last.withOpacity(0.25)
    ),
    GradientPallete(
    name: 'TAMEER', 
    gradient: Gradients.tameer,
    shaddowcolor: Gradients.tameer.colors.last.withOpacity(0.25)
    ),

];

// GradientText(
//   'Hello',
//   shaderRect: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
//   gradient: Gradients.hotLinear,
//   style: TextStyle(fontSize: 40.0,),
// ),


// CircularGradientButton(
//   child: Icon(Icons.gradient),
//   callback: (){},
//   gradient: Gradients.rainbowBlue,
//   shadowColor: Gradients.rainbowBlue.colors.last.withOpacity(0.5),
// ),

// GradientButton(
//   child: Text('Gradient'),
//   callback: () {},
//   gradient: Gradients.backToFuture,
//   shadowColor: Gradients.backToFuture.colors.last.withOpacity(0.25),
// ),

// determinate

// GradientProgressIndicator(
//   gradient: Gradients.rainbowBlue,
//   value: 0.65,
// );

// indeterminate

// GradientProgressIndicator(gradient: Gradients.rainbowBlue,);


// GradientCard(
//     gradient: Gradients.tameer,
//     shadowColor: Gradients.tameer.colors.last.withOpacity(0.25),
//     elevation: 8,
// );
