if(document.getElementsByClassName("even")) {
    var holdMe = document.getElementsByClassName("even");
    var username = document.getElementsByClassName("profile-name")[0].getElementsByClassName("mb-0")[0].textContent;
    for (var i = 0; i < holdMe.length; i++) {
        var holder = document.createElement("td");
        holder.id = "executionHolder"+i;
        var button = document.createElement("button");
        button.innerHTML = "Execute";
        button.className = "btn btn-outline-primary";
        button.id = "executionButton"+i;
        button.style = "padding-top: 6px;padding-bottom: 6px;padding-left: 15px;margin-left: 0px;margin-right: 0px; border-bottom-color: #0090e7; border-left-color: #0090e7; border-right-color: #0090e7; border-top-color: #0090e7; color: White; background-color: #0090e7;";
        
        holdMe.item(i).appendChild(holder);
        
        var holder = document.getElementById("executionHolder"+i);

        holder.appendChild(button);

        var onClick = holder.getElementsByTagName("button")[0];
        const curScript = document.getElementById("executionHolder"+i).parentElement.getElementsByClassName("sorting_1")[0].textContent;
        onClick.addEventListener('click', function() {
        
        

        });   
    }
}