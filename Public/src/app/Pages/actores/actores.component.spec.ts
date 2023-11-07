import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ActoresComponent } from './actores.component';

describe('ActoresComponent', () => {
  let component: ActoresComponent;
  let fixture: ComponentFixture<ActoresComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ActoresComponent]
    });
    fixture = TestBed.createComponent(ActoresComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
