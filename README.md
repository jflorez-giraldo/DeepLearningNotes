# Deep Learning Notes

Libro abierto de deep learning orientado a problemas, construido con Quarto y
PyTorch. La edicion HTML se publica en:

<https://jflorez-giraldo.github.io/DeepLearningNotes/>

## Desarrollo local

```bash
quarto preview
```

El libro no ejecuta automaticamente los bloques durante el render. Los
notebooks estan preparados para ejecutarse en Google Colab o en un entorno
local con las dependencias de `requirements.txt`.

Para regenerar los notebooks a partir de los capitulos:

```bash
bash scripts/build_notebooks.sh
```

## Estado

La arquitectura completa del libro y los capitulos 1 a 6 forman la version
desarrollada actual. Cubren tensores, regresion, clasificacion con MLP,
entrenamiento estable, convoluciones y redes visuales profundas. Los capitulos
restantes muestran el problema articulador, los resultados de aprendizaje y la
ruta de desarrollo.

## Licencia

El contenido se distribuye bajo CC BY-SA 4.0. Consulte `LICENSE` y
`ATTRIBUTION.md`.
