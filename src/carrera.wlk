import inscripcion.*

class Carrera{
    const property materias = #{}

    method estaEnCarrera(materia){
        return materias.contains(materia)
    }

    method alumnosDe(materia){
        self.validarMateria(materia)
        materia.alumnos()
    }

    method listaDeEsperaDe(materia){
        self.validarMateria(materia)
        materia.listaDeEspera()
    }

    method validarMateria(materia){
        if(not self.estaEnCarrera(materia)){
            self.error("la materia " + materia + "no pertenece a la carrera " + self)
        } 
    }
}
class Materia{
    const property requisitos = #{}
    var property cupo = 100
    const property alumnos = #{}
    const property listaDeEspera = #{}

    method estaCursando(alumno){
        return alumnos.contains(alumno)
    }

    method estaEnEspera(alumno){
        return listaDeEspera.contains(alumno)
    }

    method cumpleRequisitos(alumno){
        return alumno.materias().all({materia => self.cumpleRequisito(materia)})
    }

    method cumpleRequisito(materia){
        return requisitos.contains(materia)
    }

    method inscribir(alumno){
        if(self.cupo() > 0){
            alumnos.add(alumno)
            cupo = cupo - 1
        }else{
            listaDeEspera.add(alumno)
        }
    }

    method darDeBaja(alumno){
        if(not self.estaCursando(alumno)){
            self.error("no se puede dar de baja de una materia que no cursa")
        }else{
            alumnos.remove(alumno)
            self.agregarSiHayEnEspera()
        }
    }

    method agregarSiHayEnEspera(){
        if(listaDeEspera.size() > 0){
            alumnos.add(listaDeEspera.first())
        }
    }
}