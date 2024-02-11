using UnityEngine;
using System.Collections.Generic;
public class TransformationGrid : MonoBehaviour
{
    public Transform prefab;
    public int gridResolution = 10;

    private Transform[] _grid;
    private List<Transformation> _transformations;

    private void Awake()
    {
        _transformations = new List<Transformation>();
        _grid = new Transform[gridResolution * gridResolution * gridResolution];
        for (int i = 0, z = 0; z < gridResolution; z++)
        {
            for (int y = 0; y < gridResolution; y++)
            {
                for (int x = 0; x < gridResolution; x++, i++)
                {
                    _grid[i] = CreateGridPoint(x, y, z);
                }
            }
        }
    }

    void Update () {
        GetComponents<Transformation>(_transformations);
        for (int i = 0, z = 0; z < gridResolution; z++) {
            for (int y = 0; y < gridResolution; y++) {
                for (int x = 0; x < gridResolution; x++, i++) {
                    _grid[i].localPosition = TransformPoint(x, y, z);
                }
            }
        }
    }

    Vector3 TransformPoint (int x, int y, int z) {
        Vector3 coordinates = GetCoordinates(x, y, z);
        for (int i = 0; i < _transformations.Count; i++) {
            coordinates = _transformations[i].Apply(coordinates);
        }
        return coordinates;
    }
    Transform CreateGridPoint(int x, int y, int z)
    {
        Transform point = Instantiate<Transform>(prefab);
        point.localPosition = GetCoordinates(x, y, z);
        point.GetComponent<MeshRenderer>().material.color = new Color
            (  
                (float)x / gridResolution,
                (float)y / gridResolution,
                (float)z / gridResolution
            );
        return point;
    }

    Vector3 GetCoordinates(int x, int y, int z)
    {
        return new Vector3
        (
            x - (gridResolution - 1) * 0.5f,
            y - (gridResolution - 1) * 0.5f,
            z - (gridResolution - 1) * 0.5f
        );
    }
}
