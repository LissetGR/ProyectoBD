import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ConsultasComponent } from './Pages/consultas/consultas.component';
import { FuncionesComponent } from './Pages/funciones/funciones.component';
import { ActoresComponent } from './Pages/actores/actores.component';

const routes: Routes = [
  {path:'actores', component: ActoresComponent},
  {path:'consultas', component:ConsultasComponent},
  {path:'funciones', component: FuncionesComponent},
  {path:' ', pathMatch:'full', redirectTo:'actores'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
