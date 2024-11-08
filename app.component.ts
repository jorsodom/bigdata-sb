import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  temas = [
    {
      titulo: '1. Introducción a las Bases de Datos',
      subtemas: [
        '1.1 Conceptos básicos',
        '1.2 Historia de las bases de datos',
        '1.3 Sistemas de gestión de bases de datos'
      ],
      expandido: false
    },
    {
      titulo: '2. Modelado de Datos',
      subtemas: [
        '2.1 Modelos de datos',
        '2.2 Modelo entidad-relación (ER)',
        '2.3 Normalización de datos'
      ],
      expandido: false
    },
    {
      titulo: '3. Lenguaje SQL',
      subtemas: [
        '3.1 Introducción a SQL',
        '3.2 Comandos DDL y DML',
        '3.3 Consultas avanzadas'
      ],
      expandido: false
    },
    // Agrega más temas y subtemas aquí
  ];

  toggleSubtemas(tema: any) {
    tema.expandido = !tema.expandido;
  }
}
