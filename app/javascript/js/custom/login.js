$(document).ready(function () {
  $("#togglePassword").hide();

  var click = false;

  $("#user_password").on("input", function () {
    if ($(this).val() == "") {
      $("#togglePassword").hide();
    } else {
      $("#togglePassword").show();
    }
  });

  $("#togglePassword").click(function () {
    if (click == true) {
      $("#user_password").prop("type", "password");
      $(this).removeClass("mdi-eye-off");
      $(this).addClass("mdi-eye");

      click = false;
    } else {
      $("#user_password").prop("type", "text");
      $(this).removeClass("mdi-eye");
      $(this).addClass("mdi-eye-off");

      click = true;
    }
  });
});
