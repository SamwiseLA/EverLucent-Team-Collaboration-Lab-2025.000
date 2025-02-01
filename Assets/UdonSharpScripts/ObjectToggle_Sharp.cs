
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class ObjectToggle_Sharp : UdonSharpBehaviour
{
    //void Start()
    //{
    //    
    //}

    public GameObject targetToToggle;

    private void Interact(){
        targetToToggle.SetActive(!targetToToggle.activeSelf);
    }

}
