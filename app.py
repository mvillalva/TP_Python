from flask import Flask
from flask import render_template, request, redirect, flash, url_for
from flask import send_from_directory
from datetime import datetime

from cliente import *
import os

app = Flask(__name__)
app.secret_key = "Codoacodo"

cliente = Cliente(app)
CARPETA = os.path.join('uploads')
JS = os.path.join('js')
CSS = os.path.join('css')
IMG = os.path.join('img')

app.config['CARPETA'] = CARPETA
app.config['CSS'] = CSS
app.config['JS'] = JS
app.config['IMG'] = IMG


@app.route('/uploads/<filename>')
def uploads(filename):
    return send_from_directory(app.config['CARPETA'], filename)


@app.route('/css/<filename>')
def css(filename):
    return send_from_directory(app.config['CSS'], filename)


@app.route('/js/<filename>')
def js(filename):
    return send_from_directory(app.config['JS'], filename)


@app.route('/img/<filename>')
def img(filename):
    return send_from_directory(app.config['IMG'], filename)


@app.route("/")
def index():
    return render_template("main/index.html", scroll="scroll")


@app.route("/ingresar")
def ingresar():
    return render_template("main/ingresar.html", index=url_for('index'))


@app.route('/destroy/<int:id>')
def destroy(id):
    fila = cliente.select("SELECT foto from cliente WHERE id = %s", (id))
    os.remove(os.path.join(app.config['CARPETA'], fila[0][0]))

    cliente.executeSQL("DELETE FROM cliente WHERE id=%s", (id))

    return redirect('/')


@app.route('/edit/<int:id>')
def edit(id):
    clientes = cliente.select(
        "SELECT * FROM cliente WHERE id=%s", (id))

    return render_template("cliente/edit.html", clientes=clientes)


@app.route('/create')
def create():
    return render_template("clientes/create.html")


@app.route('/store', methods=['POST'])
def storage():
    _nombre = request.form['txtNombre']
    _correo = request.form['txtCorreo']
    _foto = request.files['txtFoto']

    if _nombre == '' or _foto == '' or _correo == '':
        flash("Faltan datos")
        return redirect(url_for('create'))

    now = datetime.now()
    tiempo = now.strftime("%Y%H%M%S")

    if _foto.filename != '':
        nuevoNombreFoto = tiempo + _foto.filename
        _foto.save("uploads/" + nuevoNombreFoto)

    sql = "INSERT INTO cliente (`nombre`, `correo`, `foto`) VALUES (%s, %s, %s);"

    datos = (_nombre, _correo, nuevoNombreFoto)

    cliente.executeSQL(sql, datos)

    return redirect("/")


@app.route('/update', methods=['POST'])
def update():
    _id = request.form['txtID']
    _nombre = request.form['txtNombre']
    _correo = request.form['txtCorreo']
    _foto = request.files['txtFoto']

    now = datetime.now()
    tiempo = now.strftime("%Y%H%M%S")

    nuevoNombreFoto = ''

    if _foto.filename != '':
        nuevoNombreFoto = tiempo + _foto.filename
        _foto.save("uploads/" + nuevoNombreFoto)
        fila = cliente.select(
            "SELECT foto from empleados WHERE id = %s", (_id))
        os.remove(os.path.join(app.config['CARPETA'], fila[0][0]))

    sql = "UPDATE `sistema`.`empleados` SET nombre=%s, correo=%s, foto=%s WHERE id=%s;"
    datos = (_nombre, _correo, nuevoNombreFoto, _id)

    cliente.executeSQL(sql, datos)

    return redirect("/")


if __name__ == "__main__":
    app.run(debug=True)
