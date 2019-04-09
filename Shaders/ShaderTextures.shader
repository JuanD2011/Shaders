// Directorio /Nombre del shader
Shader "Custom/Base/Base" 
{

	// Variables disponibles en el inspector (Propiedades)
	Properties 
	{ 
		_Color1("Color 1", Color) = (1, 1, 1, 1)
		_Color2("Color 2", Color) = (1, 1, 1, 1)
		_Texture1("Texture 1", 2D) = "white"{}
		_Texture2("Texture 2", 2D) = "white"{}
		_Factor("Factor", Range(0, 1)) = 0

	}

	// Primer subshader
	SubShader 
	{ 
		LOD 200
		
		CGPROGRAM
		// Método para el cálculo de la luz
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		// Información adicional provista por el juego
		struct Input 
		{
			float2 uv_Texture1;
			float2 uv_Texture2;
		};

		// Declaración de variables
		sampler2D _Texture1, _Texture2;
		float4 _Color1, _Color2;
		float _Factor;

		// Nucleo del programa
		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			/*float3 result = tex2D(_Texture1, IN.uv_Texture1) * _Color1.rgb;
			o.Albedo = result;*/

			float4 result2 = ((tex2D(_Texture1, IN.uv_Texture1) * (-_Factor + 1)) + (tex2D(_Texture2, IN.uv_Texture2) * _Factor)) * _Color1;
			o.Albedo = result2;
		}
		ENDCG

	}// Final del primer subshader

	// Segundo subshader si existe alguno
	// Tercer subshader...

	// Si no es posible ejecutar ningún subshader ejecute Diffuse
	FallBack "Diffuse"
}
