Shader "Dithered Transparent/Dithered From Texture"
{
	Properties 
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Main Texture", 2D) = "white" {}
        _DitherScale("Dither Scale", Float) = 10
        [NoScaleOffset]_DitherTex ("Dither Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags{ "RenderType" = "Opaque" "Queue" = "Geometry" }

        Pass
        {

            CGPROGRAM
            #include "UnityCG.cginc"
            #include "Dither Functions.cginc"
            #pragma target 5.0
            #pragma vertex vert
            #pragma fragment frag

            float4 _Color;
            float4 _MainTex_ST;			// For the Main Tex UV transform
            sampler2D _MainTex;			// Texture used for the line
            
            float _DitherScale;
            sampler2D _DitherTex;

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
                float4 col = _Color * tex2D(_MainTex, i.uv);
                ditherClip(i.pos, col.a, _DitherTex, _DitherScale);

	            return col;
            }

			ENDCG
		}
	}
}
