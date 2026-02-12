using RigidBodyDynamics

function main()
    # Cargar modelo
    urdf_path = joinpath(@__DIR__, "..", "models", "furuta.urdf")
    mechanism = parse_urdf(urdf_path)
    state = MechanismState(mechanism)
    
    println("✅ Modelo cargado correctamente con RigidBodyDynamics.jl")
    println("Grados de libertad: ", num_velocities(mechanism))
end


main()

