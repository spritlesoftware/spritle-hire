$(document).ready(function () {
  $("#send-mail").hide();

  $('#dashboard-datatable').DataTable({
    paging: false,
    searching: false,
    info: false,
    responsive: true
  });

  $('#users-datatable').DataTable({
    columnDefs: [
      { orderable: false, targets: [0, 6] }
    ],
    responsive: true
  });

  $('#questions-datatable').DataTable({
    columnDefs: [
      { orderable: false, targets: -1 }
    ],
    responsive: true
  });

  $('#tests-datatable').DataTable({
    columnDefs: [
      { orderable: false, targets: -1 }
    ],
    responsive: true
  });

  $('#results-datatable').DataTable({
    columnDefs: [
      { orderable: false, targets: -1 }
    ],
    responsive: true
  });

  $('#checkAll').click(function () {
    $(':checkbox.checkItem').prop('checked', this.checked);

    if ($('.checkItem').is(':checked')) {
      $('#send-mail').show();
    } else {
      $('#send-mail').hide();
      $('#checkAll').prop('checked', false);
    }
  });

  $('.checkItem').click(function () {
    if ($('.checkItem').is(':checked')) {
      $('#send-mail').show();
    } else {
      $('#send-mail').hide();
      $('#checkAll').prop('checked', false);
    }
  });

  $('#send-reminder-mail').click(function () {
    let array = [];

    $(":checkbox.checkItem:checked").each(function () {
      array.push($(this).val());
    });

    $.ajax({
      url: "/admin/users/send_reminder_mail",
      method: "POST",
      async: false,
      data: { user_ids: array },
      success: function (result) {
        window.location.reload();
      },
      error: function (err) {
        console.log(err);
      }
    });
  });

  $('#send-selection-mail').click(function () {
    let array = [];

    $(":checkbox.checkItem:checked").each(function () {
      array.push($(this).val());
    });

    $.ajax({
      url: "/admin/users/send_selection_mail",
      method: "POST",
      async: false,
      data: { user_ids: array },
      success: function (result) {
        window.location.reload();
      },
      error: function (err) {
        console.log(err);
      }
    });
  });

  $('#send-rejection-mail').click(function () {
    let array = [];

    $(":checkbox.checkItem:checked").each(function () {
      array.push($(this).val());
    });

    $.ajax({
      url: "/admin/users/send_rejection_mail",
      method: "POST",
      async: false,
      data: { user_ids: array },
      success: function (result) {
        window.location.reload();
      },
      error: function (err) {
        console.log(err);
      }
    });
  });
});
