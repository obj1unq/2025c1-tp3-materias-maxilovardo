import carrera.*

class Estudiante{
    const property aprobadas = #{}
    const property carreras = #{}

    method aprobar(nota,materia,carrera){
        self.validarAprobacion(materia)
        aprobadas.add(new Cursada(nota = nota, materia = materia, carrera = carrera))
    }

    method validarAprobacion(materia){
        if(self.tieneAprobada(materia)){
            self.error("la materia ya esta aprobada, no se puede agregar")
        }
    }

    method cantAprobadas(){
        return aprobadas.size()
    }

    method promedio(){
        return aprobadas.average({aprobada => aprobada.nota()})
    }

    method tieneAprobada(materia){
        return aprobadas.any({aprobada => aprobada.materia() == materia})
    }

    method materiasDeCarreras(){
        return carreras.materias().flatten()
    }

    method puedeInscribir(materia){
        return self.materiaEnCarrera(materia) &&
               (not self.tieneAprobada(materia)) &&
               materia.estaCursando(self) &&
               materia.cumpleRequisitos(self)
    }

    method materiaEnCarrera(materia){
        return carreras.any({carrera => carrera.estaEnCarrera(materia)})
    }

    method inscribir(materia){
        self.validarInscripcion(materia)
        materia.inscribir(self)
    }

    method validarInscripcion(materia){
        if(not self.puedeInscribir(materia)){
            self.error("no puede inscribirse en " + materia)
        }
    }

    method darDeBaja(materia){
        materia.darDeBaja(self)
    }

    method materiasCursando(){
        return self.materiasDeCarreras().filter({materia => materia.estaCursando(self)})
    }

    method materiasEnEspera(){
        return self.materiasDeCarreras().filter({materia => materia.estaEnEspera(self)})
    }

    method materiasPuedeInscribir(carrera){
        self.validarCarrera(carrera)
        carrera.materias().filter({materia => self.puedeInscribir(materia)})
    }

    method validarCarrera(carrera){
        if(not carreras.contains(carrera)){
            self.error("no esta cursando la carrera " + carrera)
        }
    }
}

class Cursada{
    const property nota
    const property materia
    const property carrera
}