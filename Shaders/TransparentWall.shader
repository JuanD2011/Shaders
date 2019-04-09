Shader "Custom/TransparentWall" 
{
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Main Texture", 2D) = "white" {}
		_Mask("Mask", 2D) = "white" {}
	}
	SubShader 
	{
		Tags 
		{ 
			"Queue" = "Transparent"
			"IgnoreProjection" = "True"
			"RenderType" = "TransparentCutout"
		}
		LOD 200

		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows alpha:fade

		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _Mask;

		struct Input 
		{
			float2 uv_MainTex;
			float2 uv_Mask;
		};

		float4 _Color;

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			float4 c = tex2D(_MainTex, IN.uv_MainTex);
			float4 mask = (1 - tex2D(_Mask, IN.uv_Mask));
			o.Albedo = c.rgb;
			o.Alpha = mask;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
