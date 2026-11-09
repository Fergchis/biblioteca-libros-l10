# biblioteca-libros: Node plano, sin dependencias que instalar. Sirve datos/catalogo.json en el 3001.
FROM node:24-alpine
WORKDIR /app
COPY libros.mjs ./
COPY datos/ ./datos/
USER node
EXPOSE 3001
CMD ["node", "libros.mjs"]
