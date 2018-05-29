document.addEventListener('DOMContentLoaded', () => {
  const $messageText = document.querySelector('#message-input #messageText');
  const $btn = document.querySelector('#message-input button');
  const $messageList = document.querySelector('#message-list ul');

  // handle message received
  App.chat.received = function(data) {
    const $messageItem = document.createElement('li');

    $messageItem.append(`${data.sent_by}: ${data.body}`);
    $messageList.append($messageItem);
  };

  // handle button click
  $btn.addEventListener('click', () => {
    const message = { body: $messageText.value };

    App.chat.send_message({ message });
    $messageText.value = '';
  });
});
