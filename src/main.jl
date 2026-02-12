using RigidBodyDynamics
using MeshCat
using MeshCatMechanisms

function main()
    # 1. Cargar modelo
    urdf_path = joinpath(@__DIR__, "..", "models", "furuta.urdf")
    mechanism = parse_urdf(urdf_path)
    state = MechanismState(mechanism)
    
    println(urdf_path)
    println("✅ Modelo cargado correctamente")

    # 2. Configurar el Visualizador
    #vis = Visualizer() # Esto crea el servidor de MeshCat
    #mcv = MechanismVisualizer(mechanism, URDFVisuals(urdf_path), vis)

    mvis = MechanismVisualizer(mechanism, URDFVisuals(urdf_path));
    


    # 3. Ejemplo: Mover el péndulo a una posición específica
    # Supongamos que q[1] es el brazo motor y q[2] es el péndulo
    set_configuration!(mcv, [0.0, 3.14]) # Poner el péndulo hacia arriba (aprox π)

    println("🚀 Visualización abierta en el navegador. Revisa la URL (usualmente localhost:8080)")
    
    return mvis
end

mvis = main()

render(vis) # Emsto abre o actualiza la pestaña

