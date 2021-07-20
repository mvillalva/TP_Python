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

let modalMessage = new bootstrap.Modal(document.getElementById('modalMessage'), {
    keyboard: false
  });

let _href;

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