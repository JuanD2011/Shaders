Shader "Custom/Transparency" 
{
	Properties 
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Treshold ("Treshold" , Range(0, 1)) = 0
	}
	SubShader 
	{
		Tags 
		{ 
			"Queue" = "Transparent"
			"IgnoreProjection" = "True"
			"RenderType"="TransparentCutout" 
		}
		LOD 200

		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows alpha:fade

		#pragma target 3.0

		sampler2D _MainTex;

		struct Input 
		{
			float2 uv_MainTex;
			float3 worldNormal;
			float3 viewDir;
		};

		float4 _Color;
		float _Treshold;

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			float4 c = tex2D(_MainTex, IN.uv_MainTex);
			float edge = abs(dot(IN.worldNormal, IN.viewDir));

			if (edge < _Treshold)
			{
				edge = 0;
			}
			else
			{
				edge = 1;
			}

			float4 cMask = (1 - edge) * _Color;
			cMask.a = 1 - edge;
			o.Albedo = cMask.rgb;
			o.Alpha = cMask.a;
			
		}
		ENDCG
	}
	FallBack "Diffuse"
}
