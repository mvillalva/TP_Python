const openFile = () => {
    image = document.getElementById("img");

    image.onchange = e => { 
        let file = e.target.files[0];

        let reader = new FileReader();
        reader.readAsDataURL(file);
        
        reader.onload = readerEvent => {
            let content = readerEvent.target.result;
            let foto = document.getElementById("foto");
            foto.classList.add('card-img-cover');
            document.querySelector('#foto').setAttribute('src',content);
        }
     }

     image.click();
};

if (document.getElementById('modalMessage1')){
    var modalMessage = new bootstrap.Modal(document.getElementById('modalMessage1'), {
        keyboard: false
    });
}

let _href;

const validaCampos = (nuevo="") => {
    if (nuevo){
        image = document.getElementById("img")
        if(!image.value){
            let modal = document.getElementById('modalMessage2');
            if (modal) {
                let modalMessage2 = new bootstrap.Modal(modal, {
                    keyboard: false
                  });
                modalMessage2.toggle();
            }
        }
    }
}

const modalConfirm = function(callback){
  
    document.querySelectorAll(".btn-accion").forEach((e) => {
        e.addEventListener("click", (e) => {
            _href = e.currentTarget.dataset.href;            
            modalMessage.toggle();
        });
    });
    
    document.getElementById("btn_ok").addEventListener("click", () => {
        callback(true)
        modalMessage.toggle();
    });
    
    document.getElementById("btn_cancel").addEventListener("click", () => {
        callback(false)
        modalMessage.toggle();
    });
  };
  
  modalConfirm(function(confirm){
    if(confirm)
        if (_href)
            window.location.href = _href;
  });