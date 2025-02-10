// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "vrium/vrium-skbx-galaxy-v2"
{
	Properties
	{
		_rotx("rot-x", Float) = 0
		_roty("rot-y", Float) = 0
		_rotz("rot-z", Float) = 0
		_layernebula("layer-nebula", 2D) = "black" {}
		_layerstars("layer-stars", 2D) = "black" {}
		_layerstarsmultiply("layer-stars-multiply", Float) = 1
		_layerstarsglow("layer-stars-glow", 2D) = "black" {}
		_glowMultiply("glowMultiply", Range( 0 , 2)) = 0
		_layerplanets("layer-planets", 2D) = "black" {}
		_noise("noise", 2D) = "black" {}
		_noiseSpeed("noiseSpeed", Vector) = (0,0,0,0)
		_noiseAmount("noiseAmount", Range( 0 , 1)) = 0
		_noiseTiling("noiseTiling", Vector) = (1,1,0,0)
		_Exposure("Exposure", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform sampler2D _layerstars;
		uniform float _rotx;
		uniform float _roty;
		uniform float _rotz;
		uniform float _layerstarsmultiply;
		uniform sampler2D _noise;
		uniform float2 _noiseSpeed;
		uniform float2 _noiseTiling;
		uniform sampler2D _layerstarsglow;
		uniform float _glowMultiply;
		uniform sampler2D _layernebula;
		uniform float _noiseAmount;
		uniform sampler2D _layerplanets;
		uniform float _Exposure;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float mulTime5_g3 = _Time.y * 0.0;
			float temp_output_21_0_g3 = ( ( ( _rotx + mulTime5_g3 ) / 360.0 ) * 6.28318548202515 );
			float3 appendResult41_g3 = (float3(0.0 , cos( temp_output_21_0_g3 ) , sin( temp_output_21_0_g3 )));
			float3 appendResult42_g3 = (float3(0.0 , -sin( temp_output_21_0_g3 ) , cos( temp_output_21_0_g3 )));
			float3x3 rotationX51_g3 = float3x3(float3(1,0,0), appendResult41_g3, appendResult42_g3);
			float mulTime7_g3 = _Time.y * 0.0;
			float temp_output_18_0_g3 = ( ( ( _roty + mulTime7_g3 ) / 360.0 ) * 6.28318548202515 );
			float3 appendResult39_g3 = (float3(cos( temp_output_18_0_g3 ) , 0.0 , -sin( temp_output_18_0_g3 )));
			float3 appendResult40_g3 = (float3(sin( temp_output_18_0_g3 ) , 0.0 , cos( temp_output_18_0_g3 )));
			float3x3 rotationY50_g3 = float3x3(appendResult39_g3, float3(0,1,0), appendResult40_g3);
			float mulTime10_g3 = _Time.y * 0.0;
			float temp_output_22_0_g3 = ( ( ( _rotz + mulTime10_g3 ) / 360.0 ) * 6.28318548202515 );
			float3 appendResult46_g3 = (float3(cos( temp_output_22_0_g3 ) , sin( temp_output_22_0_g3 ) , 0.0));
			float3 appendResult47_g3 = (float3(-sin( temp_output_22_0_g3 ) , cos( temp_output_22_0_g3 ) , 0.0));
			float3x3 rotationZ52_g3 = float3x3(appendResult46_g3, appendResult47_g3, float3(0,0,1));
			float3 viewDirRotated61_g3 = mul( ase_worldViewDir, mul( mul( rotationX51_g3, rotationY50_g3 ), rotationZ52_g3 ) );
			float3 break63_g3 = viewDirRotated61_g3;
			float2 appendResult71_g3 = (float2(( atan2( break63_g3.x , break63_g3.z ) / 6.28318548202515 ) , (1.0 + (( asin( break63_g3.y ) / ( 0.5 * UNITY_PI ) ) - -1.0) * (0.0 - 1.0) / (1.0 - -1.0))));
			float2 uvBackground95 = appendResult71_g3;
			float2 uv_TexCoord85 = i.uv_texcoord * _noiseTiling;
			float2 panner86 = ( 1.0 * _Time.y * _noiseSpeed + uv_TexCoord85);
			float mainNoise92 = tex2Dlod( _noise, float4( panner86, 0, 0.0) ).r;
			float temp_output_194_0 = ( pow( mainNoise92 , 2.5 ) * 5.0 );
			float2 temp_cast_0 = (pow( mainNoise92 , 0.1 )).xx;
			float2 blendOpSrc96 = temp_cast_0;
			float2 blendOpDest96 = uvBackground95;
			float2 lerpBlendMode96 = lerp(blendOpDest96,( blendOpSrc96 + blendOpDest96 - 1.0 ),( _noiseAmount / 10.0 ));
			float4 tex2DNode1 = tex2Dlod( _layernebula, float4( lerpBlendMode96, 0, 0.0) );
			float4 tex2DNode98 = tex2Dlod( _layerplanets, float4( uvBackground95, 0, 0.0) );
			float4 lerpResult59 = lerp( ( ( ( tex2Dlod( _layerstars, float4( uvBackground95, 0, 0.0) ) * _layerstarsmultiply * ( temp_output_194_0 + 1.0 ) ) + ( tex2Dlod( _layerstarsglow, float4( uvBackground95, 0, 0.0) ) * _glowMultiply * temp_output_194_0 ) ) + tex2DNode1 ) , tex2DNode98 , tex2DNode98.a);
			o.Emission = ( lerpResult59 * _Exposure ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}