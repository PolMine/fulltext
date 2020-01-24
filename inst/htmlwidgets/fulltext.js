HTMLWidgets.widget({
  
  name: "fulltext",
  
  type: "output",
  
  factory: function(el, width, height) {
    
    // document.annotations = {};
    // document.annotationsCreated = 0;
    // var getSelectionText; // needs to be defined globally
    
    // document.getElementsByTagName("body")[0].style.overflow = "scroll";

    // var div = document.getElementsByClassName("fulltext")[0];
    el.style.overflow = "scroll";
    el.style.padding = "5px";
    var container = el;
    var selected_subcorpus;
    var previously_selected_subcorpus;
    var tokens;
    
    var ct_filter = new crosstalk.FilterHandle();
    ct_filter.on("change", function(e) {
      tokens = document.getElementsByName(previously_selected_subcorpus);
      tokens.forEach((token) => {
        console.log(token);
        token.style.display = "none";
      })
      previously_selected_subcorpus = ct_filter.filteredKeys;
      
      tokens = document.getElementsByName(ct_filter.filteredKeys);
      tokens.forEach((token) => {
        console.log(token);
        token.style.display = "block";
      })
    });

    return {
      renderValue: function(x) {
        
        ct_filter.setGroup(x.settings.crosstalk_group);
        
        // document.annotations = x.data.annotations;
        if (x.settings.box){ container.style.border = "1px solid #ddd"; };
        
        if (x.settings.crosstalk_key){
          console.log("This is renderValue")
        };
        console.log(ct_filter.filteredKeys);

        var txt = "";
        for (var i = 0; i < x.data.token.length; i++){
            txt += x.data.tag_before[i];
            // txt += '<span style="display:none" name="';
            // txt += x.data.subcorpus_id[i];
            // txt += '">';
            txt += x.data.token[i];
            // txt += '</span>';
            txt += x.data.tag_after[i];
        };
        
        container.innerHTML = container.innerHTML + txt;
        
        /* for (var i = 0; i < x.data.annotations.id_left.length; i++){
          for (var id = x.data.annotations.id_left[i]; id <= x.data.annotations.id_right[i]; id ++){
            el = document.getElementById(id.toString())
            el.style.backgroundColor = x.data.annotations.code[i];
            el.addEventListener('contextmenu', function(ev) {
              ev.preventDefault();
              alert('success!');
              return false;
            }, true);
          };
        };
        */

        
        /* function getSelectionText() {
          var text = "";
          if (window.getSelection) {
            
            document.annotations.text.push(window.getSelection().toString());

            var id_left = parseInt(window.getSelection().anchorNode.parentNode.getAttribute("id"));
            var id_right = parseInt(window.getSelection().focusNode.parentNode.getAttribute("id"));

            document.annotations.id_left.push(id_left);
            document.annotations.id_right.push(id_right);

            var code_color = bootbox.prompt({
              title: x.settings.codeSelection,
              inputType: 'textarea',
              callback: x.settings.callbackFunction
            });
            
          } else if (document.selection && document.selection.type != "Control") {
            text = document.selection.createRange().text;
            
          } 
          
        } */
        
        /*if (x.settings.dialog){
          container.onmouseup = function(el) { getSelectionText() };
        }; */

      },
      
      resize: function(width, height) {
      }
    };
  }
});