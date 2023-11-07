import { Injectable } from '@angular/core';
import { io } from 'socket.io-client';

@Injectable({
  providedIn: 'root'
})
export class SocketIoService {
  io= io("http://localhost:3000/",{
    autoConnect:true
  })
  constructor() { }

  

  

}
