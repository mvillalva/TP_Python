let modalIngreso = new bootstrap.Modal(document.getElementById('modalIngreso'), {
    keyboard: false
});

let modalMessage = new bootstrap.Modal(document.getElementById('modalMessage'), {
    keyboard: false
});

if (modalMessage) {
    modalMessage.toggle();    
}