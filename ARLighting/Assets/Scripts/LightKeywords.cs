// 
// Author: Pratith Kanagaraj <pxk5958#rit.edu>, 2018
// 

using HoloToolkit.Unity.InputModule;
using UnityEngine;

namespace ARLighting
{
    public class LightKeywords : MonoBehaviour, ISpeechHandler
    {
        [Tooltip("Light object to be turned on / off.")]
        public GameObject LightObject;

        [Tooltip("Light emitter object whose material needs to be changed.")]
        public GameObject EmitterObject;

        [Tooltip("Material when turned on.")]
        public Material LightOnMaterial;

        [Tooltip("Material when turned off.")]
        public Material LightOffMaterial;

        public void TurnOn()
        {
            LightObject.SetActive(true);
            EmitterObject.GetComponent<MeshRenderer>().material = LightOnMaterial;
        }

        public void TurnOff()
        {
            LightObject.SetActive(false);
            EmitterObject.GetComponent<MeshRenderer>().material = LightOffMaterial;
        }

        public void OnSpeechKeywordRecognized(SpeechEventData eventData)
        {
            switch (eventData.RecognizedText.ToLower())
            {
                case "on":
                    TurnOn();
                    break;
                case "off":
                    TurnOff();
                    break;
            }
        }
    }
}