using RigidBodyDynamics
using MeshCat
using MeshCatMechanisms




function simular_movimiento_base()
    # 1. Cargar el modelo
    urdf_path = joinpath(@__DIR__, "..", "models", "furuta.urdf")
    mechanism = parse_urdf(urdf_path)
    state = MechanismState(mechanism)
    mvis = MechanismVisualizer(mechanism, URDFVisuals(urdf_path))

    # 2. Definir la función de control (Torque)
    # Esta función se llama en cada paso de la simulación
    function control!(τ, t, state)
        # τ es el vector de torques que vamos a llenar
        # state.q[1] es la posición del brazo, state.v[1] su velocidad
        
        # Vamos a aplicar un torque senoidal al brazo (articulación 1)
        # para que oscile de un lado a otro
        τ[1] = 0.1 * sin(2π * 1 * t)  # Amplitud 0.5, Frecuencia 0.5Hz
        
        # El péndulo (articulación 2) está libre, torque 0
        τ[2] = 0.0 
    end

    # 3. Estado inicial
    # El brazo en 0 y el péndulo colgando hacia abajo (cerca de π)
    # Le damos un pequeño desfase a pi (3.14) para que no esté en equilibrio perfecto
    set_configuration!(state, [0.0, 3.1]) 
    set_velocity!(state, [0.0, 0.0])

    # 4. Simulación con control
    final_time = 10.0
    # Usamos la variante de 'simulate' que acepta la función de control
    ts, qs, vs = simulate(state, final_time, control!; Δt = 0.01)

    # 5. Visualización
    println("🎬 Generando animación con movimiento de base...")
    animation = Animation(mvis, ts, qs)
    setanimation!(mvis, animation)
    
    return mvis
end

# Ejecutar y renderizar
mvis = simular_movimiento_base()
render(mvis)

function simular_furuta()
    # 1. Cargar modelo y configurar visualizador
     urdf_path = joinpath(@__DIR__, "..", "models", "furuta.urdf")
    mechanism = parse_urdf(urdf_path)
    mvis = MechanismVisualizer(mechanism, URDFVisuals(urdf_path))
    
    # 2. Definir el estado inicial
    state = MechanismState(mechanism)
    
    # Ponemos el péndulo un poco ladeado para que la gravedad actúe (ej: 0.1 rad)
    # q1 = brazo motor, q2 = péndulo
    set_configuration!(state, [0.0, 0.1]) 
    set_velocity!(state, [0.0, 0.0]) # Velocidad inicial cero
    
    # 3. Configurar la simulación
    # Definimos el tiempo final y el paso de tiempo
    final_time = 10.0
    ts, qs, vs = simulate(state, final_time; Δt = 0.01)

    # 4. Reproducir la animación en el navegador
    println("🎬 Generando animación...")
    animation = Animation(mvis, ts, qs)
    setanimation!(mvis, animation)
    
    return mvis
end

# Ejecutar
mvis = simular_furuta()
render(mvis)

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
    


    # 3. Posición inicial
    # q[1] = rotación base, q[2] = rotación péndulo
    # Ponemos el péndulo hacia arriba (π rad)
    set_configuration!(state, [0.0, 3.1415])
    set_configuration!(mvis, configuration(state))

    println("🚀 Visualización lista.")
    return mvis
end

# Ejecutar
mvis = simular_movimiento_base()
render(mvis)

render(mvis) # Emsto abre o actualiza la pestaña

