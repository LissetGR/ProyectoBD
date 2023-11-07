import { NgModule } from '@angular/core';
import { CommonModule, DatePipe } from '@angular/common';
import {MatToolbarModule} from '@angular/material/toolbar';
import {MatIconModule} from '@angular/material/icon';
import {MatButtonModule} from '@angular/material/button';
import {MatListModule} from '@angular/material/list';
import {MatMenuModule} from '@angular/material/menu';
import { RouterModule } from '@angular/router';
import {MatDialogModule} from '@angular/material/dialog';
import {MatInputModule} from '@angular/material/input';
import { FormsModule } from '@angular/forms';
import { MatDividerModule } from '@angular/material/divider';
import {MatSidenavModule} from '@angular/material/sidenav';
import {MatTabsModule} from '@angular/material/tabs';
import {MatCardModule} from '@angular/material/card';
import {MatTableModule} from '@angular/material/table';

@NgModule({
  declarations: [],
  imports: [
    CommonModule,
    MatToolbarModule,
    MatIconModule,
    MatListModule,
    MatMenuModule,
    RouterModule,
    MatDialogModule,
    MatInputModule,
    FormsModule,
    MatDividerModule,
    DatePipe,
    MatButtonModule,
    MatSidenavModule,
    MatTabsModule,
    MatCardModule,
    MatTableModule

  ],
  exports:[
    MatToolbarModule,
    MatIconModule,
    MatButtonModule,
    MatListModule,
    MatMenuModule,
    RouterModule,
    MatDialogModule,
    MatInputModule,
    FormsModule,
    MatDividerModule,
    DatePipe,
    MatSidenavModule,
    MatTabsModule,
    MatCardModule,
    MatTableModule
  ]
})
export class ModuloModule { }
