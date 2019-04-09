Shader "Custom/Movimiento2"
{
	Properties
	{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Amplitude("Amplitud", Range(0, 10)) = 0
		_AngularVelocity("Velocidad Angular", Range(0, 10)) = 0
	}
		SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
#pragma target 3.0

		sampler2D _MainTex;

	struct Input
	{
		float2 uv_MainTex;
	};
	float _Amplitude;
	float _AngularVelocity;

	// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
	// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
	// #pragma instancing_options assumeuniformscaling
	UNITY_INSTANCING_BUFFER_START(Props)
		// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf(Input IN, inout SurfaceOutputStandard o)
	{
		float2 UVMovement = IN.uv_MainTex;
		UVMovement += _Amplitude * sin(_Time.y * _AngularVelocity);
		float4 c = tex2D(_MainTex, UVMovement);
		o.Albedo = c.rgb;
	}
	ENDCG
	}
		FallBack "Diffuse"
}
