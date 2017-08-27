// Returns > 0 if not clipped, < 0 if clipped based
// on the dither
// For use with the "clip" function
float isDithered(float2 pos, float alpha) {
    // Define a dither threshold matrix which can
    // be used to define how a 4x4 set of pixels
    // will be dithered
    float4x4 DITHER_THRESHOLDS =
    {
        1.0 / 17.0,  9.0 / 17.0,  3.0 / 17.0, 11.0 / 17.0,
        13.0 / 17.0,  5.0 / 17.0, 15.0 / 17.0,  7.0 / 17.0,
        4.0 / 17.0, 12.0 / 17.0,  2.0 / 17.0, 10.0 / 17.0,
        16.0 / 17.0,  8.0 / 17.0, 14.0 / 17.0,  6.0 / 17.0
    };

    return alpha - DITHER_THRESHOLDS[pos.x % 4][pos.y % 4];
}

// Returns whether the pixel should be discarded based
// on the dither texture
float isDithered(float2 pos, float alpha, sampler2D tex, float scale) {
    pos.x -= _ScreenParams.x / 2;
    pos.y -= _ScreenParams.y / 2;
    pos.x /= scale;
    pos.y /= scale;

    return alpha - tex2D(tex, pos.xy).r;
}

// Helpers that call the above functions and clip if necessary
void ditherClip(float2 pos, float alpha) {
    clip(isDithered(pos, alpha));
}

void ditherClip(float2 pos, float alpha, sampler2D tex, float scale) {
    clip(isDithered(pos, alpha, tex, scale));
}