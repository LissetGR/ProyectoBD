import { Component } from '@angular/core';
import { Actor } from 'src/app/Model/actor';
import { GlobalServiceService } from 'src/app/Services/global-service.service';
import { SocketIoService } from 'src/app/Services/socket.io.service';

@Component({
  selector: 'app-actores',
  templateUrl: './actores.component.html',
  styleUrls: ['./actores.component.css']
})
export class ActoresComponent {
  actores:Actor[]=[]
  visible:boolean=false

  aux:Actor={
    nombre_actor:'',
    edad:0,
    id_actor:0,
    nacionalidad:'',
    genero_actor:''
  }
   
  id_unavailable:boolean=false
  

  constructor (private Global:GlobalServiceService,private Sio:SocketIoService){
    
     this.Global.getActores().subscribe(
      res=>{
          this.actores = res
      },err=>{

      }
     )
  }


  public limpiar(){
    this.aux.nombre_actor=''
    this.aux.edad=0
    this.aux.id_actor=0
    this.aux.nacionalidad=''
    this.aux.genero_actor=''
    
  }

  public ventanaVisible(){
    this.visible?this.visible=false:this.visible=true

  }
   
  public borrarActor(id_actorE:number){
   var index:number=0
    
    for(let i=0;i<this.actores.length;i++){
      if(this.actores[i].id_actor==id_actorE){
        index=i;
      }
    }
     
    this.Sio.io.emit('borrarActor',id_actorE,index);
    this.actores.splice(index,1)
  }

  public agregarActor(){
    this.id_unavailable=false
    this.ventanaVisible()
    let encontrado=false

    for(let i=0;i<this.actores.length;i++){
      if(this.actores[i].id_actor==this.aux.id_actor){
        this.editarInfoActor(this.aux)   
        this.Sio.io.emit('actualizarActor',this.aux) 
        this.ventanaVisible()
        encontrado=true
       }
    }
     if(!encontrado)  {
      this.Sio.io.emit('agregarActor',this.aux.id_actor,this.aux.nombre_actor,this.aux.genero_actor,this.aux.nacionalidad,this.aux.edad);
     } 

  }

  public editarInfoActor(e:Actor){
    this.id_unavailable=true
    this.ventanaVisible()
    this.aux=e
  }
  public Add(){
    this.id_unavailable=false
    this.ventanaVisible()

    this.aux={
    nombre_actor:'',
    edad:0,
    id_actor:0,
    nacionalidad:'',
    genero_actor:''
    }
  }

}
