let width       = 0,
    nav         = document.getElementById("navi"),
    nav_button  = document.getElementById("navi__button"),
    items       = document.querySelectorAll(".menu__item"),
    menu        = document.getElementById("menu"),
    logo        = document.getElementById("logo"),
    button      = document.getElementById("button-up");

width = window.innerWidth < 768 ? 55 : window.innerWidth >= 768 && window.innerWidth < 1024 ? 65 : 60;

//agrego evento en el botón menú para desplgar la lista
nav_button.addEventListener(
    "click",
    function () {
        if (menu.classList.contains("menu__active")) {
            menu.classList.remove("menu__active");
            this.querySelector("a").innerHTML = "<i class='fas fa-bars'></i>";
        } else {
            menu.classList.add("menu__active");
            this.querySelector("a").innerHTML = "<i class='fas fa-times'></i>";
        }
    },
    false
);

//agrego a cada item de la lista la llamada al evento click del botón del menú
items.forEach((element) => {
    element.addEventListener("click", function () {
        nav_button.click();
    });
});

//Efecto de scroll al presionar un item del menú
let scrolls = document.querySelectorAll(".scroll");

scrolls.forEach((element) => {
    element.addEventListener("click", function (event) {
        event.preventDefault();
        let elem = this.getAttribute("href");
        let obj = document.getElementById(elem.substr(1, elem.length));

        window.scroll({
            top: elem == "/" ? 0 : obj.offsetTop - obj.scrollTop - width,
            behavior: "smooth",
        });
    });
});

(function () {
    if (button)
        button.classList.add("button-up--none");
})();

//función para cambiar clases y la selección del item menú según la posición en pantalla
window.addEventListener("scroll", function () {
    if (document.documentElement.scrollTop == 0) {
        logo.classList.remove("navi__logo--0");
        logo.classList.add("navi__logo--25");
        nav.classList.remove("navi--dark");
        nav.classList.remove("navi--shadow");
        menu.classList.remove("navi--dark");
        button.classList.add("button-up--none");
    } else {
        logo.classList.add("navi__logo--0");
        logo.classList.remove("navi__logo--25");
        nav.classList.add("navi--dark");
        nav.classList.add("navi--shadow");
        menu.classList.add("navi--dark");
        button.classList.remove("button-up--none");

        let mnu_inicio      = document.getElementById("mnu_inicio"),
            mnu_destacados  = document.getElementById("mnu_destacados"),
            mnu_nosotros    = document.getElementById("mnu_nosotros"),
            mnu_clientes    = document.getElementById("mnu_clientes"),
            mnu_contacto    = document.getElementById("mnu_contacto"),
            destacados      = document.getElementById("destacados"),
            clientes        = document.getElementById("clientes"),
            nosotros        = document.getElementById("nosotros"),
            contacto        = document.getElementById("contacto"),
            items           = document.querySelectorAll(".menu__item");

        if (document.documentElement.scrollTop < destacados.offsetTop - destacados.scrollTop - width) {
            if (!mnu_inicio.parentElement.classList.contains("menu__item--select")) {
                items.forEach((element) => element.classList.remove("menu__item--select"));
                mnu_inicio.parentElement.classList.add("menu__item--select");
            }
        } else if (
            document.documentElement.scrollTop >= destacados.offsetTop - destacados.scrollTop - width &&
            document.documentElement.scrollTop < clientes.offsetTop - clientes.scrollTop - width
        ) {
            if (!mnu_destacados.parentElement.classList.contains("menu__item--select")) {
                items.forEach((element) => element.classList.remove("menu__item--select"));
                mnu_destacados.parentElement.classList.add("menu__item--select");
            }
        } else if (
            document.documentElement.scrollTop >= clientes.offsetTop - clientes.scrollTop - width &&
            document.documentElement.scrollTop < nosotros.offsetTop - nosotros.scrollTop - width
        ) {
            if (!mnu_clientes.parentElement.classList.contains("menu__item--select")) {
                items.forEach((element) => element.classList.remove("menu__item--select"));
                mnu_clientes.parentElement.classList.add("menu__item--select");
            }
        } else if (
            document.documentElement.scrollTop >= nosotros.offsetTop - nosotros.scrollTop - width &&
            document.documentElement.scrollTop < contacto.offsetTop - contacto.scrollTop - width
        ) {
            if (!mnu_nosotros.parentElement.classList.contains("menu__item--select")) {
                items.forEach((element) => element.classList.remove("menu__item--select"));
                mnu_nosotros.parentElement.classList.add("menu__item--select");
            }
        } else if (document.documentElement.scrollTop >= contacto.offsetTop - contacto.scrollTop - width) {
            if (!mnu_contacto.parentElement.classList.contains("menu__item--select")) {
                items.forEach((element) => element.classList.remove("menu__item--select"));
                mnu_contacto.parentElement.classList.add("menu__item--select");
            }
        }
    }
});

let modalIngreso = new bootstrap.Modal(document.getElementById('modalIngreso'), {
    keyboard: false
});

let modalMessage = new bootstrap.Modal(document.getElementById('modalMessage'), {
    keyboard: false
  });

if (modalMessage) {
    modalMessage.toggle();    
}

function validarIngreso(){
    let user = document.getElementById("user").value;
    let password = document.getElementById("password").value;
    let mensaje = '';    

    if (!user) {
        mensaje = 'Ingrese su nombre de usuario.'
    }
    else if (!password) {
        mensaje = 'Ingrese su contraseña.'
    }
    
    if (mensaje) {    
        let p = document.getElementById("modalIngresoMensaje");
        p.textContent = mensaje;
        
        modalIngreso.toggle();

        return  false
    }
    
    return true
}