# Utilizar la imagen base de Ubuntu

FROM ubuntu:20.04
 
ENV DEBIAN_FRONTEND=noninteractive
 
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    build-essential \
    wget \
    mysql-server\
    && apt-get clean
 
 
RUN pip3 install --upgrade pip && \
    pip3 install notebook
 
WORKDIR /workspace

# Crear el directorio de configuración de Jupyter 
RUN mkdir -p /root/.jupyter

# Añadir el archivo de configuración de Jupyter 
RUN echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py && \ 
    echo "c.NotebookApp.password = ''" >> /root/.jupyter/jupyter_notebook_config.py && \ 
    echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py && \ 
    echo "c.NotebookApp.allow_root = True" >> /root/.jupyter/jupyter_notebook_config.py
 
EXPOSE 8888 3306
 
#CMD [ "jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root" ]
CMD service mysql start && \
    jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root

#docker build -t lab_python .
#para ejecutar: docker build -t nombre .
#Para asegurarse que se creo correctamente: docker images
#Etsablecer nombre de la imagen: docker run --name nombre_container -d nombre
#docker run --name lab_python_container -p 8888:8888 -d lab_python
#docker ps

#mysql: docker run --name python-mysql -p 8889:8888 -p 3310:3306 -d lab_python_mysql
#docker exec -it lab_python_mysql bash ó docker exec -it 2dd455debce80c2480725cfedea07060d8a782ee8f5eaee1e23a8990733a6163 bash
