import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Actor } from '../Model/actor';
import { Empleado } from '../Model/Empleado';
import { Proyeccion } from '../Model/proyeccion';
import { Director } from '../Model/director';

@Injectable({
  providedIn: 'root'
})
export class GlobalServiceService {
  private url:string ="http://localhost:3000/"
  constructor(private http:HttpClient) { }
  
  public getActores(){
    return this.http.get<any>(this.url)
  }
  public getCons(){
    return this.http.get<Empleado[]>(this.url+"C1")
  }
 
  public getProyeccion(){
    return this.http.get<Proyeccion[]>(this.url+"C2")
  }
   
  public getDirectores(){
    return this.http.get<Director[]>(this.url+"C3")
  }
 
}
