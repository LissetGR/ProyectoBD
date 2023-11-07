import { Component } from '@angular/core';
import { Empleado } from 'src/app/Model/Empleado';
import { Actor } from 'src/app/Model/actor';
import { pelicula } from 'src/app/Model/pelicula';
import { Proyeccion } from 'src/app/Model/proyeccion';
import { GlobalServiceService } from 'src/app/Services/global-service.service';
import { SocketIoService } from 'src/app/Services/socket.io.service';


@Component({
  selector: 'app-funciones',
  templateUrl: './funciones.component.html',
  styleUrls: ['./funciones.component.css']
})
export class FuncionesComponent {
  
  empleadosR:Empleado[]=[]
  peliculas:pelicula[]=[]

  //funcion 1
  anno!:number
  cine!:string

 //funcion 2
 nombreActor!:string
 mes!:number

  constructor (private Global:GlobalServiceService,private Sio:SocketIoService){

 
  }
  
   public ejecutarConsulta1(){

    this.Sio.io.emit('ejecutarFuncion1',this.anno,this.cine)
    this.Sio.io.on("ejecutarConsulta1",(a:Empleado[])=>{
      this.empleadosR = a
    })
     
    this.limpiar()
   }
   
   public ejecutarConsulta2(){
     
    this.Sio.io.emit('ejecutarFuncion2',this.mes,this.nombreActor)
    this.Sio.io.on("ejecutarConsulta2",(a:pelicula[])=>{
      this.peliculas=a
    })
    
    this.limpiar()
   }


   public limpiar(){
    this.anno=0
    this.cine=' '
    this.nombreActor=' '
    this.mes=0
   }
}
