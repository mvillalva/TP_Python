from flask import Flask
from flask import render_template, request, redirect, flash, url_for
from flask import send_from_directory
from datetime import datetime

from flask.cli import routes_command

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
app.config['iduser'] = -1


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
    clientes = cliente.querySelect("call s_clientes_web()")
    return render_template("main/index.html", scroll="scroll", clientes=clientes)


@app.route("/ingresar")
def ingresar():
    return render_template("main/ingresar.html", index=url_for('index'))


@app.route('/login', methods=['POST'])
def login():
    _usuario = request.form['user']
    _pass = request.form['password']
    valido = True

    usuario = cliente.querySelect("call s_usuario(%s)", (_usuario))

    if usuario is None or len(usuario) == 0 or usuario == 'NULL':
        valido = False
    elif (_pass == usuario[0][1]):
        app.config['iduser'] = usuario[0][0]
        menues = cliente.querySelect("call s_menu(%s)", (usuario[0][0]))
        clientes = cliente.querySelect("call s_clientes(%s)", (usuario[0][0]))
    else:
        valido = False

    if not(valido):
        flash('Usuario inexistente o contraseña inválida')
        return redirect(url_for('ingresar'))

    return render_template('clientes/clientes.html', menues=menues, clientes=clientes)


@app.route('/clientes')
def clientes():
    menues = cliente.querySelect("call s_menu(%s)", (app.config['iduser']))
    clientes = cliente.querySelect("call s_clientes(%s)", (app.config['iduser']))
    return render_template('clientes/clientes.html', menues=menues, clientes=clientes)


@app.route('/nuevo')
def nuevo():
    menues = cliente.querySelect("call s_menu(%s)", (app.config['iduser']))

    return render_template('clientes/nuevo.html', menues=menues)


@app.route('/editar/<int:id>')
def editar(id):
    menues = cliente.querySelect("call s_menu(%s)", (app.config['iduser']))

    return render_template('clientes/editar.html', menues=menues)


@app.route('/altaspormes')
def altaspormes():
    pass


@app.route('/destacados')
def destacados():
    pass


@app.route('/movimientos')
def movimientos():
    pass


@app.route('/destroy/<int:id>')
def destroy(id):
    fila = cliente.select("SELECT foto from cliente WHERE id = %s", (id))
    os.remove(os.path.join(app.config['CARPETA'], fila[0][0]))

    cliente.queryExec("DELETE FROM cliente WHERE id=%s", (id))

    return redirect('/clientes')


@app.route('/add', methods=['POST'])
def storage():
    _nombre = request.form['nombre']
    _descripcion = request.form['descripcion']
    _direccion = request.form['direccion']
    _telefono = request.form['telefono']
    _correo = request.form['email']    
    _foto = request.files['img']
    _url = request.form['url']
    _mapa = request.form['mapa']

    now = datetime.now()
    tiempo = now.strftime("%Y%H%M%S")
    nuevoNombreFoto = ''

    if _foto.filename != '':
        nuevoNombreFoto = tiempo + _foto.filename
        _foto.save("uploads/" + nuevoNombreFoto)

    sql = "call iud_cliente(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"

    datos = (0, _nombre, _descripcion, nuevoNombreFoto, _direccion, _telefono, _correo, _url, _mapa, 0)

    cliente.queryExec(sql, datos)

    return redirect("/clientes")


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

    cliente.queryExec(sql, datos)

    return redirect("/clientes")


if __name__ == "__main__":
    app.run(debug=True)
