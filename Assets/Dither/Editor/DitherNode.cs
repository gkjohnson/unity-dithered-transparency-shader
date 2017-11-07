using System;
using UnityEngine;
using AmplifyShaderEditor;
using System.IO;

[Serializable]
[NodeAttributes("Dither Transparency", "CAT", "TEST DESC")]
public class DitherNode : ParentNode
{
    const string CGINC_FILE = "Dither Functions.cginc";
    static string _cgincFile = "";

    protected override void CommonInit(int uniqueId)
    {
        base.CommonInit(uniqueId);

        AddInputPort(WirePortDataType.COLOR, false, "texture");
        AddInputPort(WirePortDataType.FLOAT, false, "alpha");
        AddInputPort(WirePortDataType.FLOAT2, false, "screenPos");
        AddOutputPort(WirePortDataType.FLOAT, "clip");
    }

    public override string GenerateShaderForOutput(int outputId, ref MasterNodeDataCollector dataCollector, bool ignoreLocalvar)
    {
        UpdateCgincFile();
        dataCollector.AddToIncludes(UniqueId, _cgincFile);

        Debug.Log("HERE");
        Debug.Log(_cgincFile);

        string alphaValue = m_inputPorts[1].GenerateShaderForOutput(ref dataCollector, ignoreLocalvar);
        string screenPosValue = m_inputPorts[2].GenerateShaderForOutput(ref dataCollector, ignoreLocalvar);

        Debug.Log("AHA ");
        Debug.Log(screenPosValue);
        return "isDithered(" + screenPosValue + ", " + alphaValue + ")";
    }

    void UpdateCgincFile()
    {
        string dataPath = Application.dataPath.Replace("\\", "/");
        if (_cgincFile != "" && Directory.Exists(Path.Combine(dataPath, _cgincFile))) return;
        _cgincFile = "";

        string[] files = System.IO.Directory.GetFiles(Application.dataPath, CGINC_FILE, System.IO.SearchOption.AllDirectories);
        if (files.Length == 0) Debug.LogError("Cannnot locate '" + CGINC_FILE + "' file");
        else _cgincFile = "Assets" + files[0].Replace("\\", "/").Replace(dataPath, "");
    }
}
