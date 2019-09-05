// $(function() {
//   function buildHTML(comment){
//     var html = `<p>
//                   <strong>
//                       <a href=/users/${comment.user_id}>${comment.user_name}</a>
//                       :
//                     </strong>
//                     ${comment.text}
//                 </p>`
//     return html;
//   }
//   $('#new_comment').on('submit', function(e) {
//     e.preventDefault();
//     var formData = new FormData(this);
//     var url = $(this).attr('action')
//     $.ajax({
//       url: url,
//       type: "post",
//       data: formData,
//       dataType: 'json',
//       processData: false,
//       contentType: false
//     })
//     .done(function(data){
//       var html = buildHTML(data);
//       $('.comments').append(html)
//       $('.textbox').val('')
//     })
//     .fail(function(){
//       console.log
//       alert('error');
//     })
//   })
// })
$(function(){
  function buildHTML(comment){
    var html = `<p>
                  <strong>
                    <a href=/users/${comment.user_id}>${comment.user_name}</a>
                    ：
                  </strong>
                  ${comment.text}
                </p>`
    return html;
  };
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var href = window.location.href + '/comments'
    $.ajax({
      url: href,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.comments').append(html)
      $('.textbox').val('')
    })
    .fail(function(XMLHttpRequest, textStatus, errorThrown){
      alert('error');
      console.log("XMLHttpRequest : " + XMLHttpRequest.status);
　　  console.log("textStatus     : " + textStatus);
　　  console.log("errorThrown    : " + errorThrown.message);
    });
  });
});