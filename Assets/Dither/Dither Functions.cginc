float isDithered(float2 pos, float alpha) {
    float4x4 DITHER_THRESHOLDS =
    {
        1.0 / 17.0,  9.0 / 17.0,  3.0 / 17.0, 11.0 / 17.0,
        13.0 / 17.0,  5.0 / 17.0, 15.0 / 17.0,  7.0 / 17.0,
        4.0 / 17.0, 12.0 / 17.0,  2.0 / 17.0, 10.0 / 17.0,
        16.0 / 17.0,  8.0 / 17.0, 14.0 / 17.0,  6.0 / 17.0
    };

    pos.x *= _ScreenParams.x;
    pos.y *= _ScreenParams.y;
    return alpha - DITHER_THRESHOLDS[pos.x % 4][pos.y % 4];
}

void ditherClip(float2 pos, float alpha) {
    clip(isDithered(pos, alpha));
}