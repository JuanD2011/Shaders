Shader "Custom/Movimiento"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Mask ("Mask", 2D) = "white" {}
		_XVelocity ("Velocidad X", Range(0, 1)) = 0
		_YVelocity("Velocidad Y", Range(0, 1)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
		sampler2D _Mask;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_Mask;
        };

        fixed4 _Color;
		float _XVelocity;
		float _YVelocity;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float2 UVMovement = IN.uv_MainTex;
			float distanciaX = _XVelocity * _Time.y;
			float distanciaY = _YVelocity * _Time.y;
			UVMovement += float2(distanciaX, distanciaY);
			float4 c = tex2D(_MainTex, UVMovement);
            o.Albedo = c.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
