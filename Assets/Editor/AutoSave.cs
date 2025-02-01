using UnityEngine;
using UnityEditor;
using UnityEditor.SceneManagement;

[InitializeOnLoad]

public class AutoSave 
{
    static AutoSave()
    {
        EditorApplication.playModeStateChanged += SaveOnPlay ;
    }

    private static void SaveOnPlay(PlayModeStateChange state) 
    {
        if(state == PlayModeStateChange.ExitingEditMode) 
        {
            Debug.Log("AutoSaving...");
            EditorSceneManager.SaveOpenScenes();
            AssetDatabase.SaveAssets();
        }
    }

}
