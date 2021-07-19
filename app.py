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
uploads = os.path.join('uploads')
JS = os.path.join('js')
CSS = os.path.join('css')
IMG = os.path.join('img')

app.config['UPLOADS'] = uploads
app.config['CSS'] = CSS
app.config['JS'] = JS
app.config['IMG'] = IMG
app.config['iduser'] = -1


@app.route('/uploads/<filename>')
def uploads(filename):
    return send_from_directory(app.config['UPLOADS'], filename)


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
        clientes = cliente.querySelect("call s_clientes(%s, 0, 0)", (usuario[0][0]))
    else:
        valido = False

    if not(valido):
        flash('Usuario inexistente o contraseña inválida')
        return redirect(url_for('ingresar'))

    return render_template('clientes/clientes.html', menues=menues, clientes=clientes)


@app.route('/clientes')
def clientes():
    menues = cliente.querySelect("call s_menu(%s)", (app.config['iduser']))
    clientes = cliente.querySelect("call s_clientes(%s, 0, 0)", (app.config['iduser']))

    return render_template('clientes/clientes.html', menues=menues, clientes=clientes)


@app.route('/nuevo')
def nuevo():
    menues = cliente.querySelect("call s_menu(%s)", (app.config['iduser']))

    return render_template('clientes/nuevo.html', menues=menues)


@app.route('/editar/<int:id>')
def editar(id):
    menues = cliente.querySelect("call s_menu(%s)", (app.config['iduser']))
    clientes = cliente.querySelect("call s_clientes(%s, %s, 0)", (app.config['iduser'], id))

    return render_template('clientes/editar.html', menues=menues, clientes=clientes)


@app.route('/altaspormes')
def altaspormes():
    pass


@app.route('/destacados')
def destacados():
    menues = cliente.querySelect("call s_menu(%s)", (app.config['iduser']))
    clientes = cliente.querySelect("call s_clientes(%s, 0, 1)", (app.config['iduser']))

    return render_template('clientes/destacados.html', menues=menues, clientes=clientes)


@app.route('/movimientos')
def movimientos():
    pass


@app.route('/eliminar/<int:id>')
def eliminar(id):
    fila = cliente.querySelect("SELECT imagen FROM cliente WHERE id = %s", (id))
    if os.path.isfile(os.path.join(app.config['UPLOADS'])):
        os.remove(os.path.join(app.config['UPLOADS'], fila[0][0]))

    sql = "call iud_cliente(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
    datos = (id, '', '', '', 0, '', '', '', '', '', 1)

    cliente.queryExec(sql, datos)

    return redirect('/clientes')


@app.route('/store', methods=['POST'])
def storage():
    _id     = int(request.form['idCliente'])
    _nombre = request.form['nombre']
    _descripcion = request.form['descripcion']
    _destacado = request.form['destacado']
    _direccion = request.form['direccion']
    _telefono = request.form['telefono']
    _correo = request.form['email']    
    _foto = request.files['img']
    _url = request.form['url']
    _mapa = request.form['mapa']

    now = datetime.now()
    tiempo = now.strftime("%Y%H%M%S")
    nuevoNombreFoto = ''
    favorito = 0

    if _foto.filename != '':
        nuevoNombreFoto = tiempo + _foto.filename
        _foto.save("uploads/" + nuevoNombreFoto)
        if _id > 0:
            fila = cliente.querySelect("SELECT imagen FROM cliente WHERE id = %s", (_id))
            if len(fila) > 0:
                os.remove(os.path.join(app.config['UPLOADS'], fila[0][0]))
    
    if _destacado == 'on':
        favorito = 1

    sql = "call iud_cliente(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"

    datos = (_id, _nombre, _descripcion, nuevoNombreFoto, favorito, _direccion, _telefono, _correo, _url, _mapa, 0)

    cliente.queryExec(sql, datos)

    return redirect("/clientes")


if __name__ == "__main__":
    app.run(debug=True)
