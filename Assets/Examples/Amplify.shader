// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Example/Amplify"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Color0("Color 0", Color) = (1,0,0,0)
		_DitherMaskScale("Dither Mask Scale", Float) = 40
		_DitherMask("Dither Mask", 2D) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" }
		Cull Back
		CGPROGRAM
		#include "Assets/Dither/Dither Functions.cginc"
		#pragma target 5.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred 
		struct Input
		{
			float4 screenPos;
		};

		uniform float4 _Color0;
		uniform sampler2D _DitherMask;
		uniform float _DitherMaskScale;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = _Color0.rgb;
			float temp_output_3_0 = 0.5;
			o.Metallic = temp_output_3_0;
			o.Smoothness = temp_output_3_0;
			o.Alpha = 1;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			clip( ceil(isDithered(ase_screenPosNorm.xy * _ScreenParams.xy, _Color0.a, _DitherMask, _DitherMaskScale)) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13501
474;321;1550;931;1486.524;230.5966;1.3;True;True
Node;AmplifyShaderEditor.TexturePropertyNode;12;-711.1742,83.20001;Float;True;Property;_DitherMask;Dither Mask;2;0;Assets/Textures/dot-dither-sample.png;False;white;Auto;0;1;SAMPLER2D
Node;AmplifyShaderEditor.ColorNode;2;-1032.351,-49.86012;Float;False;Property;_Color0;Color 0;0;0;1,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;13;-709.2385,286.507;Float;False;Property;_DitherMaskScale;Dither Mask Scale;2;0;40;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.ScreenPosInputsNode;6;-752.6089,432.1866;Float;False;0;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DitherNode;14;-415.76,332.6459;Float;False;4;0;SAMPLER2D;;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;3;-427.7937,46.09684;Float;False;Constant;_Float;Float;0;0;0.5;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-145.4751,-49.50623;Float;False;True;7;Float;ASEMaterialInspector;0;0;Standard;Example/Amplify;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;Back;0;0;False;0;0;Masked;0.5;True;True;0;False;TransparentCutout;AlphaTest;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;12;0
WireConnection;14;1;13;0
WireConnection;14;2;2;4
WireConnection;14;3;6;0
WireConnection;0;0;2;0
WireConnection;0;3;3;0
WireConnection;0;4;3;0
WireConnection;0;10;14;0
ASEEND*/
//CHKSM=48241B5BAA367E0D5E0D0D74D7A3A52C8F18766B