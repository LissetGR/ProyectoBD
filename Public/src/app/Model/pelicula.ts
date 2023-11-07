import { Time } from "@angular/common";

export interface pelicula{
    id_pelicula:number,
    duracion:Time,
    director:String,
    genero:String,
    titulo_original:String,
    pais_origen:String,
    id_director:number,
    info_actores:string[]
}