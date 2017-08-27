using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OscillateAlpha : MonoBehaviour {

    private void Start()
    {
        GetComponent<Renderer>().sharedMaterial = new Material(GetComponent<Renderer>().sharedMaterial);
    }
    void Update () {
        Material mat = GetComponent<Renderer>().sharedMaterial;
        Color col = mat.color;
        col.a = Mathf.Sin(Time.timeSinceLevelLoad * 2) * 0.5f + 0.5f;
        mat.color = col;
	}
}
