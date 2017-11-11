# unity-dithered-transparency-shader

![example](./docs/example.gif)

Unity shader to enable a dithered transparency when rendering transparent objects

## Use

Uses the material's alpha to determine whether a pixel should be discarded or not. Either a dither matrix or dither texture can be used.

## Dither Options
**Dither Texture**

Texture defining the dither pattern. The "red" channel is used from the texture to compare against the materials alpha.

**Dither Scale**

The scale of the dither texture in screen-space pixels.

## Extending and Reuse
The functions for performing the dither effect are available in the [Dither Functions.cginc](./Assets/Dither/Dither%20Functions.cginc) so they can easily be added to and used with other shaders and functions.

### In Visual Shader Builders

[Amplify Shader Editor](/docs/AmplifyShaderEditor.md)

[ShaderForge](/docs/ShaderForge.md)

## TODO
- Update the dither functions to take [0,1] screen coordinates
