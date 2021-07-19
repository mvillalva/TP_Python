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
