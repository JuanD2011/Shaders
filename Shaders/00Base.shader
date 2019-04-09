// Directorio /Nombre del shader
Shader "Custom/Base/Base" 
{

	// Variables disponibles en el inspector (Propiedades)
	Properties 
	{ 
		//_ColorAmbiente ("Color Ambiente", Color) = (1,1,1,1)
		_Color1("Color 1", Color) = (1, 1, 1, 1)
		_Color2("Color 2", Color) = (1, 1, 1, 1)
		_Emission("Emission", Color) = (1, 1, 1, 1)

		slider("Slider", Range(0, 1)) = 0
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
		struct Input {
			float2 uv_MainTex;
		};

		// Declaración de variables
		//float4 _ColorAmbiente;
		float4 _Color1, _Color2, _Emission;
		float slider;

		// Nucleo del programa
		void surf (Input IN, inout SurfaceOutputStandard o) 
		{

			/*float4 c = _ColorAmbiente;
			o.Albedo = c.rgb;*/

			//1
			/*float4 average = (_Color1 + _Color2) / 2;
			o.Albedo = average.rgb;*/

			//2
			float4 average = (_Color1 * (-slider + 1)) + (_Color2 * slider);
			o.Albedo = average.rgb;

			//3

			o.Emission = _Emission.rgb;
		}
		ENDCG

	}// Final del primer subshader

	// Segundo subshader si existe alguno
	// Tercer subshader...

	// Si no es posible ejecutar ningún subshader ejecute Diffuse
	FallBack "Diffuse"
}
