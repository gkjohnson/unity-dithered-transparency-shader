﻿using System;
using UnityEngine;
using System.IO;
using AmplifyShaderEditor;

[Serializable]
[NodeAttributes("Dither Transparency", "GarrettJohnson", "Applies a dither pattern in screen space based on the alpha.\n\n<b>Alpha</b> and <b>screenPos</b> are expected to be from [0, 1].\n\nIf <b>mask</b> is connected, then the texture is used in place of the dither pattern with <b>maskScale</b> specifying the number of pixels the mask should cover.")]
public class AmplifyDitherNode : ParentNode
{
    const string CGINC_FILE = "Dither Functions.cginc";
    static string _cgincFile = "";

    // Initialize the inputs and outputs
    protected override void CommonInit(int uniqueId)
    {
        base.CommonInit(uniqueId);

        AddInputPort(WirePortDataType.SAMPLER2D, false, "mask");
        AddInputPort(WirePortDataType.FLOAT, false, "maskScale");
        AddInputPort(WirePortDataType.FLOAT, false, "alpha");
        AddInputPort(WirePortDataType.FLOAT2, false, "screenPos");

        AddOutputPort(WirePortDataType.FLOAT, "clip");
    }

    // Return the code to call the dither function
    public override string GenerateShaderForOutput(int outputId, ref MasterNodeDataCollector dataCollector, bool ignoreLocalvar)
    {
        UpdateCgincFile();
        dataCollector.AddToIncludes(UniqueId, _cgincFile);

        string maskValue = m_inputPorts[0].GenerateShaderForOutput(ref dataCollector, ignoreLocalvar);
        string maskScale = m_inputPorts[1].GenerateShaderForOutput(ref dataCollector, ignoreLocalvar);
        string alphaValue = m_inputPorts[2].GenerateShaderForOutput(ref dataCollector, ignoreLocalvar);
        string screenPosValue = m_inputPorts[3].GenerateShaderForOutput(ref dataCollector, ignoreLocalvar);

        if (m_inputPorts[0].ConnectionCount == 0)
        {
            return "ceil(isDithered(" + screenPosValue + ".xy, " + alphaValue + "))";
        }
        else
        {
            return "ceil(isDithered(" + screenPosValue + ".xy, " + alphaValue + ", " + maskValue + ", " + maskScale + "))";
        }
    }

    // Find the cginc file with the functions if it exists
    void UpdateCgincFile()
    {
        // if we already haf the handle, then return
        string dataPath = Application.dataPath.Replace("\\", "/");
        if (_cgincFile != "" && Directory.Exists(Path.Combine(dataPath, _cgincFile))) return;
        _cgincFile = "";

        // search for the cginc file
        string[] files = System.IO.Directory.GetFiles(Application.dataPath, CGINC_FILE, System.IO.SearchOption.AllDirectories);
        if (files.Length == 0) Debug.LogError("Cannnot locate '" + CGINC_FILE + "' file");
        else _cgincFile = "Assets" + files[0].Replace("\\", "/").Replace(dataPath, "");
    }
}
