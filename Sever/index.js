const express = require('express');
const cors = require('cors')
const app = express();
const { Server } = require('socket.io');
const {createServer} = require("http")
const httpServer =  createServer(app)
const { Client } = require('pg');
const port = 3000;

const database = {
    user: 'postgres',
    host: 'localhost',
    database: 'ProyectoBD',
    password: '1234',
    port: 5432,
}
const io = new Server(httpServer,{
    cors:{
        origin:true,
        credentials:true,
        methods:["GET","POST"]
    }
})

const client = new Client(database);

client.connect();

app.get('/', cors(), (request, resolve) => {
    client.query('select * from actor')
        .then(resp => {
            resolve.json(resp.rows);
        })
        .catch(err => {
            resolve.status(404).end();
        })
})
app.get('/C1', cors(), (request, resolve) => {
    client.query('select * from consulta1')
        .then(resp => {
            resolve.json(resp.rows);
        })
        .catch(err => {
            resolve.status(404).end();
        })
})
app.get('/C2', cors(), (request, resolve) => {
    client.query('select * from consulta2')
        .then(resp => {
            resolve.json(resp.rows);
        })
        .catch(err => {
            resolve.status(404).end();
        })
})
app.get('/C3', cors(), (request, resolve) => {
    client.query('select * from consulta4')
        .then(resp => {
            resolve.json(resp.rows);
        })
        .catch(err => {
            resolve.status(404).end();
        })
})

io.on("connection", (socket) => {

    socket.on("borrarActor", async (id_actor, index) => {
        await client
            .query(`Delete  from Actor where  Actor.id_actor = ${id_actor};`)
            .then((resp) => {
               io.emit("borrarActorF", (index))
            })
            .catch((err) => {
               io.emit.status(404)
            })
    });

    socket.on("agregarActor", async (id_actor, nombre , genero, nacionalidad, edad) => {
        await client
        .query(`Insert into Actor(id_actor,genero_actor,edad,nombre_actor,nacionalidad) values (${id_actor}, '${genero}', ${edad},'${nombre}','${nacionalidad}')`)
        .then((resp)=>
          io.emit("agregarActor")
        )
        .catch((err)=>{
            io.emit.status(404)
        })
    })

    socket.on("actualizarActor", async (e)=>{
        await client
        .query(`Update Actor set nombre_actor='${ e.nombre_actor}', genero_actor='${e.genero_actor}', nacionalidad='${e.nacionalidad}', edad=${e.edad} where id_actor=${e.id_actor}`)
        .then((resp)=>
           io.emit("editarInfoActor")
        )
        .catch((err)=>{
           io.emit.status(404);
        })
    })

   socket.on('ejecutarFuncion1', async (anno, cine)=>{
    await client
    .query(`Select * from funcion1('${cine}',${anno})`)
    .then((resp)=>{
      io.emit("ejecutarConsulta1",resp.rows)}
    )
    .catch((err)=>{
        io.emit.status(404);
    })
   })

   socket.on('ejecutarFuncion2', async ( mes, nombre)=>{
    await client
    .query(`Select * from funcion2(${mes},'${nombre}')`)
    .then((resp)=>{
      io.emit("ejecutarConsulta2", resp.rows)
    }
    )
    .catch((err)=>{
        io.emit.status(404);
    })
   })
})
app.use(express.json())
httpServer.listen(3000)
console.log("Server on port 3000")

