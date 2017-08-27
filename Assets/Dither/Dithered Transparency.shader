Shader "Transparent/Dithered"
{
	Properties 
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Main Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags{ "RenderType" = "Opaque" "Queue" = "Geometry" }

        Pass
        {

            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma target 5.0
            #pragma vertex vert
            #pragma fragment frag

            float4 _Color;
            float4 _MainTex_ST;			// For the Main Tex UV transform
            sampler2D _MainTex;			// Texture used for the line
            
            struct v2f
            {
                float4	pos		: POSITION;
                float2  uv		: TEXCOORD0;
            };

            v2f vert(appdata_base v)
            {
                v2f output;
                output.pos = UnityObjectToClipPos(v.vertex);
                output.uv = TRANSFORM_TEX(v.texcoord, _MainTex);

                return output;
            }

            float4 frag(v2f i) : COLOR
            {
                i.pos.x *= _ScreenParams.x;
                i.pos.y *= _ScreenParams.y;

                float2 samp = float2(i.pos.x % 4, i.pos.y % 4);
                float4x4 thresh =
                {
                    1.0 / 17.0,  9.0 / 17.0,  3.0 / 17.0, 11.0 / 17.0,
                    13.0 / 17.0,  5.0 / 17.0, 15.0 / 17.0,  7.0 / 17.0,
                    4.0 / 17.0, 12.0 / 17.0,  2.0 / 17.0, 10.0 / 17.0,
                    16.0 / 17.0,  8.0 / 17.0, 14.0 / 17.0,  6.0 / 17.0
                };


                clip(_Color.a - thresh[samp.x][samp.y]);

	            return _Color;
            }

			ENDCG
		}
	}
}
