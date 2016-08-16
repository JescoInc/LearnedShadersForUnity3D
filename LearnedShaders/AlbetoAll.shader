// Tells Unity where shader will be in the Editor
Shader "Jesco/WhiteOut" 
{
	SubShader
	{
		// This shader renders opaque. No transparencies
		Tags {"RenderType" = "Opaque"}
		
		// CG code block
		CGPROGRAM
		// calls pregenerated shader code for Lambert. Basic lighting
		#pragma surface surf Lambert

		struct Input
	{
		// data type of float4 ( 4 decimal values of float)
		float4 color : COLOR; // (1.0, 1.0, 1.0, 1.0) aka RGBA (Red, Green, Blue, Alpha)
	};

	// surf was created with the pragma
	void surf(Input IN, inout SurfaceOutput o)
	{
		o.Albedo = 1;
	}
		ENDCG
	}
		// if shader fails, we have a fallback shader
	Fallback "Diffuse"
}