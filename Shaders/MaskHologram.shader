Shader "Custom/MaskHologram" 
	{
		Properties
		{
			_Color("Color", Color) = (1,1,1,1)
			_MainTex("Albedo (RGB)", 2D) = "white" {}
			_Treshold("Treshold" , Range(0, 1)) = 0
			_Mask("Mask", 2D) = "white" {}
			_XVelocity("X Velocity" , Range(0, 1)) = 0
			_YVelocity("Y Velocity" , Range(0, 1)) = 0
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
					float3 worldNormal;
					float3 viewDir;
				};

				float4 _Color;
				float _Treshold;
				float _XVelocity;
				float _YVelocity;

				void surf(Input IN, inout SurfaceOutputStandard o)
				{
					float4 c = tex2D(_MainTex, IN.uv_MainTex);
					float2 maskUV = IN.uv_Mask;
					maskUV += float2(_XVelocity * _Time.y, _YVelocity * _Time.y);
					float4 mask = tex2D(_Mask, maskUV);
					float edge = abs(dot(IN.worldNormal, IN.viewDir));

					if (edge < _Treshold)
					{
						edge = 0;
					}
					else
					{
						edge = 1;
					}

					o.Albedo = c.rgb;
					o.Alpha = (1 - edge) + mask.r;
				}
				ENDCG
			}
				FallBack "Diffuse"
	}
