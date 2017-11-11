Shader "Hidden/Dithered Transparent/Shadow"
{
    Properties 
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Main Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags{ "LightMode" = "ShadowCaster" }

        Pass
        {
            Name "SHADOW"

            CGPROGRAM
            #include "UnityCG.cginc"
            #include "Dither Functions.cginc"
            #pragma vertex vert
            #pragma fragment frag

            float4 _Color;
            float4 _MainTex_ST;         // For the Main Tex UV transform
            sampler2D _MainTex;         // Texture used for the line
            
            struct v2f
            {
                float4 pos      : POSITION;
                float2 uv       : TEXCOORD0;
                float4 spos     : TEXCOORD1;
            };

            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);

                return o;
            }

            float4 frag(v2f i) : COLOR
            {
                float4 col = _Color * tex2D(_MainTex, i.uv);
                ditherClip(i.spos.xy / i.spos.w, col.a);

                return float4(0,0,0,0); 
            }

            ENDCG
        }
    }
}
