document.addEventListener('DOMContentLoaded', function() {
  var $messageText = document.querySelector('#message-input #messageText');
  var $btn = document.querySelector('#message-input button');
  var $messageList = document.querySelector('#message-list ul');

  // handle message received
  App.chat.received = function(data) {
    var $messageItem = document.createElement('li');

    $messageItem.append(data.sent_by + ': ' + data.body);
    $messageList.append($messageItem);
  };

  // handle button click
  $btn.addEventListener('click', function() {
    var message = { body: $messageText.value };

    App.chat.send_message({ message: message });
    $messageText.value = '';
  });
});
