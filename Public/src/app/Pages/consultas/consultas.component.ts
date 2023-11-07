import { Component } from '@angular/core';
import { Empleado } from 'src/app/Model/Empleado';
import { Director } from 'src/app/Model/director';
import { Proyeccion } from 'src/app/Model/proyeccion';
import { GlobalServiceService } from 'src/app/Services/global-service.service';
import { SocketIoService } from 'src/app/Services/socket.io.service';


@Component({
  selector: 'app-consultas',
  templateUrl: './consultas.component.html',
  styleUrls: ['./consultas.component.css']
})
export class ConsultasComponent {

  empleados:Empleado[]=[]
  proyecciones:Proyeccion[]=[]
  directores:Director[]=[]


  displayedColumns: string[] = ['nombre_empleado', 'edad', 'direccion', 'horas_trabajo','id_cine','id_sala', 'fecha_contrato','empleado2'];

 constructor (private Global:GlobalServiceService,private Sio:SocketIoService){

  this.Global.getCons().subscribe(
    res=>{
      this.empleados = res
    },err=>{

    }
  )

  this.Global.getProyeccion().subscribe(
    res=>{
      this.proyecciones=res
   },err=>{

   }

  )


  this.Global.getDirectores().subscribe(
    res=>{
      this.directores=res
   },err=>{

   }

  )
 }

}
